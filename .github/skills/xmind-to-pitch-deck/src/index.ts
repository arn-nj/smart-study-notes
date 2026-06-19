import { writeFile } from "node:fs/promises";
import path from "node:path";
import { parseInputToDeckModel } from "./parser.js";
import { generateRevealDeckHtml } from "./deckGenerator.js";

type CliArgs = {
  input: string;
  out: string;
  autoScroll: boolean;
  dynamicContent: boolean;
  dynamicDepth: number;
  preserveSourceContent: boolean;
  outMindmapJson?: string;
};

function parseIntFlag(value: string | undefined, fallback: number): number {
  if (!value) return fallback;
  const parsed = Number.parseInt(value, 10);
  if (!Number.isFinite(parsed)) return fallback;
  return parsed;
}

function parseBooleanFlag(value: string | undefined, fallback: boolean): boolean {
  if (!value) return fallback;
  const normalized = value.trim().toLowerCase();
  if (["1", "true", "yes", "on"].includes(normalized)) return true;
  if (["0", "false", "no", "off"].includes(normalized)) return false;
  return fallback;
}

function parseArgs(argv: string[]): CliArgs {
  const args = new Map<string, string>();
  for (let i = 0; i < argv.length; i += 1) {
    const token = argv[i];
    if (!token.startsWith("--")) continue;
    const key = token.slice(2);
    const value = argv[i + 1] && !argv[i + 1].startsWith("--") ? argv[i + 1] : "";
    args.set(key, value);
  }

  const input = args.get("input");
  if (!input) {
    throw new Error("Missing required argument: --input <path-to-.xmind-or-.json>");
  }

  const out = args.get("out") || path.join(process.cwd(), "pitch-deck.html");
  const autoScroll = parseBooleanFlag(args.get("auto-scroll"), false);
  const dynamicContent = parseBooleanFlag(args.get("dynamic-content"), true);
  const dynamicDepth = Math.max(0, Math.min(3, parseIntFlag(args.get("dynamic-depth"), 1)));
  const preserveSourceContent = parseBooleanFlag(args.get("preserve-source-content"), true);
  const outMindmapJson = args.get("out-mindmap-json") || undefined;
  return { input, out, autoScroll, dynamicContent, dynamicDepth, preserveSourceContent, outMindmapJson };
}

function toEnrichedMindMapJson(model: Awaited<ReturnType<typeof parseInputToDeckModel>>): string {
  const payload = {
    title: model.deckTitle,
    subtitle: model.deckSubtitle,
    children: model.slides.map((slide) => ({
      title: slide.title,
      children: slide.blocks.map((block) => ({
        title: block.title,
        children: block.points.map((point) => ({ title: point, children: [] }))
      }))
    }))
  };
  return JSON.stringify(payload, null, 2);
}

async function main(): Promise<void> {
  const cli = parseArgs(process.argv.slice(2));
  const model = await parseInputToDeckModel(cli.input, {
    dynamicContent: cli.dynamicContent,
    dynamicDepth: cli.dynamicDepth,
    preserveSourceContent: cli.preserveSourceContent
  });
  const html = generateRevealDeckHtml(model, { autoScroll: cli.autoScroll });
  await writeFile(cli.out, html, "utf-8");

  if (cli.outMindmapJson) {
    await writeFile(cli.outMindmapJson, toEnrichedMindMapJson(model), "utf-8");
  }

  process.stdout.write(`Deck generated: ${cli.out}\n`);
  process.stdout.write(`Slides: ${model.slides.length}\n`);
  process.stdout.write(`Theme: ${model.industry}\n`);
  process.stdout.write("Kinetic style: intelligent-mixed\n");
  process.stdout.write(`Auto scroll: ${cli.autoScroll ? "on" : "off"}\n`);
  process.stdout.write(`Dynamic content: ${cli.dynamicContent ? "on" : "off"} (depth ${cli.dynamicDepth})\n`);
  process.stdout.write(`Preserve source content: ${cli.preserveSourceContent ? "on" : "off"}\n`);
  if (cli.outMindmapJson) {
    process.stdout.write(`Enriched mindmap JSON: ${cli.outMindmapJson}\n`);
  }
}

main().catch((err: unknown) => {
  const message = err instanceof Error ? err.message : String(err);
  process.stderr.write(`xmind-to-pitch-deck failed: ${message}\n`);
  process.exitCode = 1;
});
