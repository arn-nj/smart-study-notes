import { readFile } from "node:fs/promises";
import path from "node:path";
import JSZip from "jszip";
import { XMLParser } from "fast-xml-parser";
import type { DeckModel, DeckSlide, TopicNode, SlideVisual } from "./types.js";
import { detectIndustry } from "./themeSelector.js";

type ParseOptions = {
  dynamicContent?: boolean;
  dynamicDepth?: number;
  preserveSourceContent?: boolean;
};

const IMAGE_EXT_TO_MIME: Record<string, string> = {
  ".svg": "image/svg+xml",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".webp": "image/webp",
  ".gif": "image/gif",
  ".bmp": "image/bmp"
};

function normalizeTitle(value: unknown): string {
  if (typeof value !== "string") return "Untitled";
  const t = value.trim();
  return t.length ? t : "Untitled";
}

function asArray<T>(value: T | T[] | undefined): T[] {
  if (!value) return [];
  return Array.isArray(value) ? value : [value];
}

function dedupeVisuals(items: SlideVisual[]): SlideVisual[] {
  const seen = new Set<string>();
  const out: SlideVisual[] = [];
  for (const item of items) {
    const key = `${item.src}::${item.alt}`;
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(item);
  }
  return out;
}

async function resolveXMindAssetSrc(src: string, zip: JSZip): Promise<string | undefined> {
  if (!src) return undefined;
  const trimmed = src.trim();
  if (!trimmed) return undefined;
  if (/^(https?:|data:|file:|\.\/|\.\.\/)/i.test(trimmed)) return trimmed;

  const normalized = trimmed.replace(/^xap:/i, "").replace(/^\/+/, "");
  const entry = zip.file(normalized);
  if (!entry) {
    return trimmed;
  }

  const ext = path.extname(normalized).toLowerCase();
  const mime = IMAGE_EXT_TO_MIME[ext] ?? "application/octet-stream";
  const base64 = await entry.async("base64");
  return `data:${mime};base64,${base64}`;
}

function isLikelyImagePath(value: string): boolean {
  return /\.(svg|png|jpe?g|webp|gif|bmp)(\?.*)?$/i.test(value) || /^data:image\//i.test(value);
}

function findHrefValue(obj: any): string | undefined {
  if (!obj || typeof obj !== "object") return undefined;
  for (const [k, v] of Object.entries(obj)) {
    if (typeof v !== "string") continue;
    const key = String(k).toLowerCase();
    if (key === "href" || key.endsWith(":href")) return v;
  }
  return undefined;
}

async function fromXMindJsonTopic(topic: any, zip?: JSZip): Promise<TopicNode> {
  const children = asArray(topic?.children?.attached);
  const candidates = [topic?.image?.src, topic?.href].filter((v): v is string => typeof v === "string" && v.trim().length > 0);
  const resolvedVisuals: SlideVisual[] = [];

  for (const candidate of candidates) {
    const src = zip ? await resolveXMindAssetSrc(candidate, zip) : candidate;
    if (!src || !isLikelyImagePath(src)) continue;
    resolvedVisuals.push({ src, alt: normalizeTitle(topic?.title) });
  }

  const mappedChildren = await Promise.all(children.map((child) => fromXMindJsonTopic(child, zip)));

  return {
    title: normalizeTitle(topic?.title),
    children: mappedChildren,
    visuals: dedupeVisuals(resolvedVisuals)
  };
}

function fromXMindXmlTopic(topic: any): TopicNode {
  const collectXmlChildTopics = (childrenNode: any): any[] => {
    if (!childrenNode) return [];

    const candidates = asArray(childrenNode);
    const out: any[] = [];

    for (const candidate of candidates) {
      if (!candidate || typeof candidate !== "object") continue;

      if (candidate.topics?.topic) {
        out.push(...asArray(candidate.topics.topic));
      }

      if (Array.isArray(candidate.topics)) {
        for (const topicsEntry of candidate.topics) {
          if (topicsEntry?.topic) {
            out.push(...asArray(topicsEntry.topic));
          }
        }
      }

      if (candidate.children) {
        out.push(...collectXmlChildTopics(candidate.children));
      }
    }

    return out;
  };

  const childTopics = collectXmlChildTopics(topic?.children);
  const rawTitle =
    topic?.title ??
    topic?.TEXT ??
    topic?.["#text"] ??
    topic?.label ??
    "Untitled";
  const href = findHrefValue(topic);
  const visuals = href && isLikelyImagePath(href)
    ? [{ src: href, alt: normalizeTitle(rawTitle) }]
    : [];
  return {
    title: normalizeTitle(rawTitle),
    children: childTopics.map(fromXMindXmlTopic),
    visuals
  };
}

async function parseXMindArchive(inputPath: string): Promise<TopicNode> {
  const raw = await readFile(inputPath);
  const zip = await JSZip.loadAsync(raw);

  const contentJson = zip.file("content.json");
  if (contentJson) {
    const payload = JSON.parse(await contentJson.async("string"));
    const firstSheet = asArray(payload)[0];
    const rootTopic = firstSheet?.rootTopic;
    if (!rootTopic) {
      throw new Error("Invalid .xmind: missing rootTopic in content.json");
    }
    return fromXMindJsonTopic(rootTopic, zip);
  }

  const contentXml = zip.file("content.xml");
  if (contentXml) {
    const parser = new XMLParser({ ignoreAttributes: false, attributeNamePrefix: "" });
    const xml = parser.parse(await contentXml.async("string"));
    const xmlRoot = xml?.["xmap-content"] ?? xml?.xmap_content ?? xml;
    const firstSheet = asArray(xmlRoot?.sheet)[0];
    const rootTopic = firstSheet?.topic;
    if (!rootTopic) {
      throw new Error("Invalid .xmind: missing root topic in content.xml");
    }
    return fromXMindXmlTopic(rootTopic);
  }

  throw new Error("Unsupported .xmind format: missing content.json/content.xml");
}

async function parseExportedJson(inputPath: string): Promise<TopicNode> {
  const raw = await readFile(inputPath, "utf-8");
  const payload = JSON.parse(raw);

  if (payload?.rootTopic) {
    return fromXMindJsonTopic(payload.rootTopic);
  }

  if (Array.isArray(payload) && payload[0]?.rootTopic) {
    return fromXMindJsonTopic(payload[0].rootTopic);
  }

  if (payload?.title && payload?.children) {
    return fromXMindJsonTopic(payload);
  }

  throw new Error("Unsupported JSON structure. Expected XMind exported JSON with rootTopic.");
}

function toSlideId(title: string, index: number): string {
  const slug = title
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 42);
  return `${index + 1}-${slug || "slide"}`;
}

const EXCLUDED_BLOCK_TITLE = /(flash\s*card|q\s*&\s*a|\bq\/a\b|question\s*&\s*answer|pitfall|clarification|interesting\s+talking\s+point|narrative\s+flow|one\s*page\s*revision|one-page\s*revision)/i;

const EXCLUDED_POINT_TEXT = /^(q\s*:\s*|a\s*:\s*|flash\s*card\s*:|one\s*page\s*revision\s*:)/i;

const CANONICAL_LEVEL2_TITLES = [
  "Concept Deep Dive",
  "Worked Example",
  "Demo Walkthrough",
  "Advanced Scenario",
  "Trade-offs"
] as const;

const IN_THIS_SECTION_TITLE = "In this section";

const LEVEL2_NORMALIZATION_RULES: Array<{ pattern: RegExp; canonical: (typeof CANONICAL_LEVEL2_TITLES)[number] }> = [
  { pattern: /^(concept\s+deep\s*dive|deep\s*dive|key\s+concepts?|core\s+idea|fundamentals?|how\s+it\s+works)/i, canonical: "Concept Deep Dive" },
  { pattern: /^(worked\s+example|example|applied\s+example|practical\s+example|use\s+case|case\s+study)/i, canonical: "Worked Example" },
  { pattern: /^(demo\s+walkthrough|walkthrough|step\s*by\s*step|steps?|implementation\s+steps?|process\s+flow)/i, canonical: "Demo Walkthrough" },
  { pattern: /^(advanced\s+scenario|edge\s+case|failure\s+mode|what\s+if|high-constraint\s+case)/i, canonical: "Advanced Scenario" },
  { pattern: /^(trade-?offs?|pros\s+and\s+cons|decision\s+criteria|limitations?|risks?)/i, canonical: "Trade-offs" }
];

function isAudienceHookTitle(title: string): boolean {
  return /^in\s+this\s+section$/i.test(title);
}

function shouldKeepBlockTitle(title: string): boolean {
  return !EXCLUDED_BLOCK_TITLE.test(title);
}

function filterPoints(points: string[]): string[] {
  return points.filter((p) => !EXCLUDED_POINT_TEXT.test(p));
}

function normalizeLevel2Title(title: string, options: ParseOptions): string {
  if (options.preserveSourceContent ?? true) return title.trim();
  if (isAudienceHookTitle(title)) return IN_THIS_SECTION_TITLE;
  for (const rule of LEVEL2_NORMALIZATION_RULES) {
    if (rule.pattern.test(title)) {
      return rule.canonical;
    }
  }
  return title;
}

function flattenDescendantTitles(nodes: TopicNode[]): string[] {
  const out: string[] = [];
  const stack = [...nodes];
  while (stack.length) {
    const current = stack.shift()!;
    const title = current.title?.trim();
    if (title) out.push(title);
    if (current.children?.length) {
      stack.unshift(...current.children);
    }
  }
  return out;
}

function uniqueLines(lines: string[]): string[] {
  const seen = new Set<string>();
  const out: string[] = [];
  for (const raw of lines) {
    const line = raw.trim();
    if (!line) continue;
    const key = line.toLowerCase();
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(line);
  }
  return out;
}

function hasPrefixedLine(lines: string[], prefix: string): boolean {
  const pattern = new RegExp(`^${prefix}\\s*:`, "i");
  return lines.some((line) => pattern.test(line));
}

function pickFirstMatching(lines: string[], regex: RegExp): string | undefined {
  return lines.find((line) => regex.test(line));
}

function stripKnownPrefix(line: string): string {
  return line
    .replace(/^scenario\s*:\s*/i, "")
    .replace(/^why\s+it\s+matters\s*:\s*/i, "")
    .replace(/^in\s+summary\s*:\s*/i, "")
    .replace(/^what\s+you(?:'|’)ll\s+learn\s*:\s*/i, "")
    .trim();
}

function buildAudienceHookPoints(slideTitle: string, existing: string[], seedPoints: string[]): string[] {
  const points = uniqueLines(existing);

  const realWorldSeed =
    pickFirstMatching(seedPoints, /(real[-\s]?world|use\s*case|case\s*study|scenario|application)/i) ??
    seedPoints[0] ??
    slideTitle;

  const learnSeed =
    pickFirstMatching([...points, ...seedPoints], /what\s+you(?:'|’)ll\s+learn\s*:/i) ??
    pickFirstMatching(seedPoints, /(key\s+takeaway|you\s+will\s+learn|learn|understand|master)/i) ??
    seedPoints[0] ??
    slideTitle;

  if (!hasPrefixedLine(points, "Scenario")) {
    points.push(`Scenario: ${stripKnownPrefix(realWorldSeed)}`);
  }

  if (!hasPrefixedLine(points, "Why it matters")) {
    const whySeed =
      pickFirstMatching(seedPoints, /(improve|reduce|increase|faster|reliable|quality|outcome|benefit|risk)/i) ??
      realWorldSeed;
    points.push(`Why it matters: ${stripKnownPrefix(whySeed)}`);
  }

  if (!hasPrefixedLine(points, "In summary")) {
    points.push(`In summary: ${stripKnownPrefix(learnSeed)}`);
  }

  return uniqueLines(points);
}

function enrichBlockPoints(slideTitle: string, blockTitle: string, points: string[], depth: number): string[] {
  const base = uniqueLines(points);
  if (depth <= 0) return base;

  const enriched = [...base];
  if (depth >= 1) {
    enriched.push(`Applied scenario: In ${slideTitle}, ${blockTitle.toLowerCase()} guides the first implementation decision.`);
  }
  if (depth >= 2) {
    enriched.push(`Complex condition: Add scale, compliance, and latency constraints to stress-test this approach.`);
  }
  if (depth >= 3) {
    enriched.push(`Decision checkpoint: Choose between speed, reliability, and cost; justify the selected trade-off.`);
  }

  return uniqueLines(enriched);
}

function enrichBlocksForNarrative(slideTitle: string, blocks: Array<{ title: string; points: string[] }>, options: ParseOptions): Array<{ title: string; points: string[] }> {
  if (options.preserveSourceContent ?? true) {
    return blocks;
  }

  const enableDynamic = options.dynamicContent ?? true;
  const depth = Math.max(0, Math.min(3, options.dynamicDepth ?? 1));

  const seedPoints = uniqueLines(
    blocks
      .filter((b) => !/^in\s+this\s+section$/i.test(b.title))
      .flatMap((b) => b.points)
  );

  const withHook = blocks.map((block) => {
    if (/^in\s+this\s+section$/i.test(block.title)) {
      return { ...block, points: buildAudienceHookPoints(slideTitle, block.points, seedPoints) };
    }
    return { ...block };
  });

  if (!withHook.some((b) => /^in\s+this\s+section$/i.test(b.title))) {
    withHook.unshift({
      title: IN_THIS_SECTION_TITLE,
      points: buildAudienceHookPoints(slideTitle, [], seedPoints)
    });
  }

  if (!enableDynamic || depth <= 0) {
    return withHook;
  }

  return withHook.map((block) => {
    if (/^in\s+this\s+section$/i.test(block.title)) return block;
    return {
      ...block,
      points: enrichBlockPoints(slideTitle, block.title, block.points, depth)
    };
  });
}

function mapMainTopicToSlide(node: TopicNode, index: number, options: ParseOptions): DeckSlide {
  const mergedBlocks = new Map<string, string[]>();
  const mergedBlockVisuals = new Map<string, SlideVisual[]>();

  for (const child of node.children) {
    if (!shouldKeepBlockTitle(child.title)) continue;
    const normalizedTitle = normalizeLevel2Title(child.title, options);
    const points = filterPoints(flattenDescendantTitles(child.children)).filter((p) => p.trim().length > 0);

    if (!mergedBlocks.has(normalizedTitle)) {
      mergedBlocks.set(normalizedTitle, []);
    }
    mergedBlocks.get(normalizedTitle)!.push(...points);

    if (child.visuals && child.visuals.length) {
      if (!mergedBlockVisuals.has(normalizedTitle)) mergedBlockVisuals.set(normalizedTitle, []);
      mergedBlockVisuals.get(normalizedTitle)!.push(...child.visuals);
    }
  }

  const preserveSourceContent = options.preserveSourceContent ?? true;
  const orderedTitles = preserveSourceContent
    ? Array.from(mergedBlocks.keys())
    : (() => {
      const hasHook = mergedBlocks.has(IN_THIS_SECTION_TITLE);
      const inputOrderTitles = Array.from(mergedBlocks.keys()).filter((t) => t !== IN_THIS_SECTION_TITLE && !CANONICAL_LEVEL2_TITLES.includes(t as (typeof CANONICAL_LEVEL2_TITLES)[number]));
      return [
        ...(hasHook ? [IN_THIS_SECTION_TITLE] : []),
        ...CANONICAL_LEVEL2_TITLES.filter((t) => mergedBlocks.has(t)),
        ...inputOrderTitles
      ];
    })();

  const childBlocks = orderedTitles
    .map((title) => {
      const deduped = Array.from(new Set(mergedBlocks.get(title) ?? []));
      return { title, points: deduped };
    })
    .filter((block) => block.points.length > 0);

  if (!childBlocks.length) {
    childBlocks.push({ title: "Concept Deep Dive", points: [node.title] });
  }

  const enrichedBlocks = enrichBlocksForNarrative(node.title, childBlocks, options);

  const blockVisuals: Record<string, SlideVisual[]> = {};
  for (const [title, visuals] of mergedBlockVisuals.entries()) {
    const deduped = dedupeVisuals(visuals);
    if (deduped.length) blockVisuals[title] = deduped;
  }

  return {
    id: toSlideId(node.title, index),
    title: node.title,
    subtitle: "Narrative section",
    blocks: enrichedBlocks,
    visuals: dedupeVisuals(node.visuals ?? []),
    blockVisuals
  };
}

type SvgIndexEntry = {
  file: string;
  concept: string;
  pages: number[];
};

function parseSvgIndexMarkdown(markdown: string): SvgIndexEntry[] {
  const lines = markdown.split(/\r?\n/);
  const entries: SvgIndexEntry[] = [];

  for (const line of lines) {
    if (!line.trim().startsWith("|")) continue;
    const cols = line
      .split("|")
      .map((v) => v.trim())
      .filter((v) => v.length > 0);
    if (cols.length < 2) continue;
    if (/^file$/i.test(cols[0]) || /^-{3,}$/i.test(cols[0].replace(/\s/g, ""))) continue;

    const fileMatch = cols[0].match(/\((?:\.\/)?([^()]+\.svg)\)/i) ?? cols[0].match(/([A-Za-z0-9_.\- ]+\.svg)/i);
    if (!fileMatch) continue;
    const file = fileMatch[1].trim();
    const concept = cols[1].replace(/[*`]/g, "").trim() || "Concept visual";
    const pagesCol = cols.find((c) => /page/i.test(c)) ?? "";
    const pages = Array.from(new Set((pagesCol.match(/\d+/g) ?? []).map((n) => Number(n)).filter((n) => Number.isFinite(n) && n > 0)));
    entries.push({ file, concept, pages });
  }

  return entries;
}

async function loadSlideVisuals(inputPath: string, slideCount: number): Promise<Map<number, SlideVisual[]>> {
  const inputDir = path.dirname(inputPath);
  const svgIndexPath = path.join(inputDir, "svg", "INDEX.md");

  try {
    const indexMd = await readFile(svgIndexPath, "utf-8");
    const entries = parseSvgIndexMarkdown(indexMd);
    const visualsBySlide = new Map<number, SlideVisual[]>();

    if (!entries.length) return visualsBySlide;

    // First pass: explicit page mapping from the index table.
    for (const entry of entries) {
      const src = path.posix.join("svg", entry.file.replace(/\\/g, "/"));
      const visual: SlideVisual = { src, alt: entry.concept };
      for (const page of entry.pages) {
        if (page < 1 || page > slideCount) continue;
        if (!visualsBySlide.has(page)) visualsBySlide.set(page, []);
        visualsBySlide.get(page)!.push(visual);
      }
    }

    // Second pass: sequential fallback for entries without page annotations.
    let fallbackPage = 1;
    for (const entry of entries) {
      if (entry.pages.length > 0) continue;
      const page = Math.min(fallbackPage, slideCount);
      const src = path.posix.join("svg", entry.file.replace(/\\/g, "/"));
      const visual: SlideVisual = { src, alt: entry.concept };
      if (!visualsBySlide.has(page)) visualsBySlide.set(page, []);
      visualsBySlide.get(page)!.push(visual);
      fallbackPage += 1;
    }

    return visualsBySlide;
  } catch {
    return new Map<number, SlideVisual[]>();
  }
}

export async function parseInputToDeckModel(inputPath: string, options: ParseOptions = {}): Promise<DeckModel> {
  const isXMind = inputPath.toLowerCase().endsWith(".xmind");
  const isJson = inputPath.toLowerCase().endsWith(".json");

  if (!isXMind && !isJson) {
    throw new Error("Input must be .xmind or .json");
  }

  const root = isXMind ? await parseXMindArchive(inputPath) : await parseExportedJson(inputPath);
  const mainTopics = root.children;
  const slides = mainTopics.map((topic, index) => mapMainTopicToSlide(topic, index, options));
  const visualsBySlide = await loadSlideVisuals(inputPath, slides.length);
  const slidesWithVisuals = slides.map((slide, i) => ({
    ...slide,
    visuals: dedupeVisuals([...(slide.visuals ?? []), ...(visualsBySlide.get(i + 1) ?? [])]),
    blockVisuals: (() => {
      const map: Record<string, SlideVisual[]> = { ...(slide.blockVisuals ?? {}) };
      const conceptBlock = slide.blocks.find((b) => /^concept\s+deep\s+dive$/i.test(b.title))?.title ?? slide.blocks[0]?.title;
      const fromIndex = visualsBySlide.get(i + 1) ?? [];
      if (conceptBlock) {
        map[conceptBlock] = dedupeVisuals([...(map[conceptBlock] ?? []), ...(slide.visuals ?? []), ...fromIndex]);
      }
      return map;
    })()
  }));
  const deckTitle = root.title;
  const deckSubtitle = "Cinema-grade animated pitch deck";
  const allText = [
    root.title,
    ...mainTopics.map((n) => n.title),
    ...mainTopics.flatMap((n) => n.children.map((c) => c.title))
  ].join(" ");

  return {
    deckTitle,
    deckSubtitle,
    industry: detectIndustry(allText),
    slides: slidesWithVisuals
  };
}
