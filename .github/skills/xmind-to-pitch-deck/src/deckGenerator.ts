import type { DeckModel, DeckSlide, SlideBlock } from "./types.js";
import { getTheme } from "./themeSelector.js";

export type DeckRenderOptions = {
  autoScroll?: boolean;
};

const EMPHASIS_PATTERN = /^(ai|agent|agents|loop|tool|tools|architecture|workflow|build|debug|cli|core|interactive|hook|context|memory|system|design|model|prompt|execution|speed|latency|security|scale)$/iu;

function escapeHtml(value: string): string {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/\"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function encodePathForHtml(value: string): string {
  return encodeURI(value.replace(/\\/g, "/"));
}

function renderBlock(block: SlideBlock, blockIndex: number): string {
  // Keep card entrances energetic but geometrically stable for clean alignment.
  const motionVariants = ["fade-up", "sweep-in", "pop-in"] as const;
  const blockMotion = motionVariants[blockIndex % motionVariants.length];
  const isInitialBlock = blockIndex === 0;
  const cleanTitle = stripSectionPrefix(block.title);
  const isOverviewCard = /^in this section$/i.test(cleanTitle) || /^audience hook$/i.test(cleanTitle);
  const points = block.points.length
    ? block.points
        .map(
          (p, i) => {
            const pointMotion = motionVariants[(blockIndex + i + 1) % motionVariants.length];
            const isInitialPoint = i === 0;
            return `
            <li class="cinema-fragment${isInitialPoint ? "" : ` fragment ${pointMotion}`}" data-motion="${pointMotion}"${isInitialPoint ? "" : ` data-fragment-index="${(blockIndex + 1) * 10 + i + 1}"`}>
              <span class="point-line">${splitHeadline(p, "point")}</span>
            </li>`;
          }
        )
        .join("")
    : `
      <li class="cinema-fragment fade-up" data-motion="fade-up">
        No nested points provided for this block.
      </li>`;

  return `
    <div class="cinema-fragment kinetic-card${isInitialBlock ? "" : ` fragment ${blockMotion}`}${isOverviewCard ? " is-overview-card" : ""} border rounded-2xl p-6 mb-5 panel" style="--card-index:${blockIndex};" data-motion="${blockMotion}" data-card-index="${blockIndex}"${isInitialBlock ? "" : ` data-fragment-index="${(blockIndex + 1) * 10}"`}>
      <h3 class="text-2xl font-semibold mb-3 tracking-tight block-title">${splitHeadline(cleanTitle, "block")}</h3>
      <ul class="list-disc ml-6 space-y-2 text-lg text-slate-100/95">
        ${points}
      </ul>
    </div>`;
}

function splitHeadline(text: string, role: "title" | "block" | "point" = "title"): string {
  const words = text.split(/\s+/).filter(Boolean);
  return words
    .map((w, i) => {
      const cleaned = w.replace(/[^\p{L}\p{N}-]/gu, "");
      const isLong = cleaned.length >= 10;
      const isEmph = EMPHASIS_PATTERN.test(cleaned) || isLong;
      const isPunct = /[:!?]/u.test(w);
      const intensity = role === "title" ? (isEmph ? "high" : "mid") : role === "block" ? (isEmph ? "mid" : "low") : isEmph ? "mid" : "low";
      const classes = [
        "kinetic-word",
        "inline-block",
        "mr-2",
        isEmph ? "is-emph" : "",
        isPunct ? "is-punct" : ""
      ]
        .filter(Boolean)
        .join(" ");
      return `<span class="${classes}" data-intensity="${intensity}" style="--word-index:${i}">${escapeHtml(w)}</span>`;
    })
    .join("");
}

function stripSectionPrefix(text: string): string {
  return text
    .replace(/^\s*\d+\s*[.)\-:]\s*/u, "")
    .replace(/^\s*\d+\s+/u, "")
    .trim();
}

function renderVisualDrawer(visuals: NonNullable<DeckSlide["visuals"]>, keySeed: string): string {
  if (!visuals.length) return "";
  const single = visuals.length === 1;
  const cards = visuals
    .map(
      (visual, i) => `
        <figure class="deck-visual-card${single ? " is-single" : ""}">
          <img class="deck-visual-img" src="${escapeHtml(encodePathForHtml(visual.src))}" alt="${escapeHtml(visual.alt)}" loading="lazy" decoding="async" />
          <figcaption class="deck-visual-caption">${escapeHtml(visual.alt)}</figcaption>
        </figure>`
    )
    .join("");

  return `
    <details open class="cinema-fragment fragment sweep-in visual-drawer" data-motion="sweep-in" data-fragment-index="${900 + Number(keySeed.replace(/\D/g, "") || 0)}">
      <summary>Concept Diagram${visuals.length > 1 ? "s" : ""}</summary>
      <section class="deck-visuals${single ? " deck-visuals--single" : ""}">
        ${cards}
      </section>
    </details>`;
}

function renderSlide(slide: DeckSlide, index: number): string {
  const blocks = slide.blocks
    .map((block, i) => {
      const blockHtml = renderBlock(block, i);
      const visualsForBlock = slide.blockVisuals?.[block.title] ?? [];
      const isConcept = /^concept\s+deep\s+dive$/i.test(block.title);
      if (isConcept && visualsForBlock.length) {
        return `${blockHtml}`;
      }
      return blockHtml;
    })
    .join("\n");

  const hasConceptVisuals = slide.blocks.some((b) => /^concept\s+deep\s+dive$/i.test(b.title) && (slide.blockVisuals?.[b.title]?.length ?? 0) > 0);
  const fallbackVisuals = "";
  const showSubtitle = Boolean(slide.subtitle && !/^\s*narrative section\s*$/i.test(slide.subtitle));
  const titleMarkup = splitHeadline(stripSectionPrefix(slide.title), "title");
  return `
    <section data-auto-animate data-slide-index="${index}" class="h-full w-full">
      <div class="slide-shell h-full flex flex-col justify-start text-left px-6 py-4">
        <h2 aria-hidden="true" class="text-5xl font-black leading-tight cinema-fragment kinetic-title kinetic-title-center">${titleMarkup}</h2>
        <h2 class="text-5xl font-black leading-tight cinema-fragment kinetic-title kinetic-title-top">${titleMarkup}</h2>
        ${showSubtitle ? `<p class="text-xl opacity-80 mb-6 cinema-fragment fragment sweep-in" data-motion="sweep-in" data-fragment-index="2">${escapeHtml(slide.subtitle ?? "")}</p>` : ""}
        <div class="content-viewport">
          ${blocks}
          ${fallbackVisuals}
        </div>
      </div>
    </section>`;
}

export function generateRevealDeckHtml(model: DeckModel, options: DeckRenderOptions = {}): string {
  const theme = getTheme(model.industry);
  const slidesHtml = model.slides.map(renderSlide).join("\n");
  const autoScroll = options.autoScroll ?? false;

  return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${escapeHtml(model.deckTitle)}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;900&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.css" />
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: {
            display: ['Outfit', 'sans-serif']
          }
        }
      }
    };
  </script>
  <style>
    :root {
      --accent: ${theme.accent};
      --accent-soft: ${theme.accentSoft};
      --text-main: ${theme.textMain};
      --text-muted: ${theme.textMuted};
    }
    html, body {
      width: 100%;
      height: 100%;
      background: #020617;
      color: var(--text-main);
      font-family: 'Outfit', sans-serif;
      letter-spacing: 0.01em;
    }
    .reveal {
      font-size: 26px;
      color: var(--text-main);
    }
    .reveal .slides {
      text-align: left;
    }
    .reveal .slides section[data-slide-index] {
      width: 100% !important;
      height: 100% !important;
      max-width: none !important;
      max-height: none !important;
      box-sizing: border-box;
      overflow: visible !important;
    }
    .video-bg {
      background: radial-gradient(circle at 20% 20%, rgba(255,255,255,0.08), transparent 30%), linear-gradient(135deg, #020617, #0f172a 45%, #111827 100%);
    }
    .industry-bg {
      background-image: linear-gradient(145deg, rgba(2,6,23,0.96), rgba(2,6,23,0.88)), linear-gradient(145deg, var(--accent), var(--accent-soft));
      background-blend-mode: overlay;
    }
    .panel {
      position: relative;
      overflow: hidden;
      background: rgba(15, 23, 42, 0.72);
      border-color: rgba(148, 163, 184, 0.35);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
      backdrop-filter: none;
    }
    .kinetic-card {
      transform-origin: center;
      will-change: transform, opacity, filter;
      max-height: 1400px;
      transition:
        opacity 420ms cubic-bezier(.22,.61,.36,1),
        transform 420ms cubic-bezier(.22,.61,.36,1),
        max-height 520ms cubic-bezier(.2,.7,.2,1),
        margin 520ms cubic-bezier(.2,.7,.2,1),
        padding 520ms cubic-bezier(.2,.7,.2,1),
        border-color 320ms ease;
    }
    .kinetic-card.is-past-card {
      pointer-events: none;
    }
    .kinetic-card::after {
      content: "";
      position: absolute;
      inset: 0;
      pointer-events: none;
      border-radius: 1rem;
      opacity: 0.42;
      background: linear-gradient(110deg, transparent 0%, color-mix(in srgb, var(--accent-soft) 35%, transparent) 45%, transparent 100%);
      transform: translateX(-35%);
      animation: cardSheen 3.6s ease-in-out infinite;
      animation-delay: calc((var(--card-index, 0) * 120ms));
    }
    @keyframes cardSheen {
      0%, 20% {
        opacity: 0;
        transform: translateX(-42%);
      }
      45% {
        opacity: 0.4;
      }
      70% {
        opacity: 0;
        transform: translateX(42%);
      }
      100% {
        opacity: 0;
        transform: translateX(42%);
      }
    }
    .slide-shell {
      gap: 0;
      position: relative;
      width: 100%;
      box-sizing: border-box;
      overflow: visible;
    }
    .kinetic-title {
      font-size: clamp(2rem, 4.8vw, 4.5rem) !important;
      line-height: 1.06;
    }
    .kinetic-title-center {
      position: absolute;
      left: 50%;
      top: 50%;
      width: min(92vw, 1600px);
      margin: 0;
      text-align: center;
      transform: translate(-50%, -50%);
      z-index: 3;
      pointer-events: none;
    }
    .kinetic-title-top {
      position: relative;
      width: 100%;
      margin: 0 0 0.9rem 0;
      text-align: left;
      opacity: 0;
      transform: translateY(20px);
      z-index: 2;
    }
    .block-title {
      font-size: clamp(1.2rem, 2.1vw, 2rem) !important;
    }
    .point-line {
      font-size: clamp(0.95rem, 1.35vw, 1.25rem);
      line-height: 1.45;
    }
    .content-viewport {
      max-height: 100%;
      overflow: hidden;
      width: 100%;
      padding-right: 0;
      box-sizing: border-box;
      scrollbar-width: none;
      opacity: 0;
      transform: translateY(26px);
    }
    .content-viewport::-webkit-scrollbar {
      width: 0;
      height: 0;
    }
    .content-viewport::-webkit-scrollbar-track {
      background: rgba(15, 23, 42, 0.55);
      border-radius: 999px;
    }
    .content-viewport::-webkit-scrollbar-thumb {
      background: linear-gradient(180deg, var(--accent-soft), var(--accent));
      border-radius: 999px;
      border: 2px solid rgba(15, 23, 42, 0.65);
    }
    @keyframes titleCenterOut {
      0% {
        opacity: 1;
        transform: translate(-50%, -50%);
      }
      100% {
        opacity: 0;
        transform: translate(-50%, -118%);
      }
    }
    @keyframes titleTopIn {
      0% {
        opacity: 0;
        transform: translateY(20px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }
    @keyframes contentIn {
      0% {
        opacity: 0;
        transform: translateY(26px);
      }
      100% {
        opacity: 1;
        transform: translateY(0);
      }
    }
    .reveal .slides section.present .kinetic-title-center {
      animation: titleCenterOut 620ms ease-in-out 780ms forwards;
    }
    .reveal .slides section.present .kinetic-title-top {
      animation: titleTopIn 580ms ease-out 860ms forwards;
    }
    .reveal .slides section.present .content-viewport {
      animation: contentIn 450ms ease 900ms forwards;
    }
    .title-glow {
      text-shadow: 0 0 35px color-mix(in srgb, var(--accent) 55%, transparent);
    }
    .reveal .fragment.fade-up {
      opacity: 0;
      transform: translateY(18px);
    }
    .reveal .fragment.fade-up.visible {
      opacity: 1;
      transform: translateY(0);
      transition: all 680ms cubic-bezier(.2,.7,.2,1);
    }
    .reveal .fragment.lift-tilt {
      opacity: 0;
      transform: translateY(30px) rotateX(10deg) scale(0.98);
    }
    .reveal .fragment.lift-tilt.visible {
      opacity: 1;
      transform: translateY(0) rotateX(0) scale(1);
      transition: all 760ms cubic-bezier(.17,.84,.44,1);
    }
    .reveal .fragment.sweep-in {
      opacity: 0;
      transform: translateY(14px);
    }
    .reveal .fragment.sweep-in.visible {
      opacity: 1;
      transform: translateY(0);
      transition: all 720ms cubic-bezier(.22,.61,.36,1);
    }
    .reveal .fragment.pop-in {
      opacity: 0;
      transform: scale(0.92);
    }
    .reveal .fragment.pop-in.visible {
      opacity: 1;
      transform: scale(1);
      transition: all 680ms cubic-bezier(.34,1.56,.64,1);
    }
    .reveal .fragment.zoom-spin {
      opacity: 0;
      transform: scale(0.8) rotate(-4deg);
      filter: blur(5px);
    }
    .reveal .fragment.zoom-spin.visible {
      opacity: 1;
      transform: scale(1) rotate(0deg);
      filter: blur(0);
      transition: all 760ms cubic-bezier(.16,1,.3,1);
    }
    .reveal .fragment.flip-in {
      opacity: 0;
      transform: rotateY(18deg) translateY(20px);
      transform-origin: left center;
    }
    .reveal .fragment.flip-in.visible {
      opacity: 1;
      transform: rotateY(0deg) translateY(0);
      transition: all 730ms cubic-bezier(.19,1,.22,1);
    }
    .kinetic-word {
      will-change: transform, opacity, filter;
      transform-origin: center bottom;
    }
    .kinetic-word.is-emph {
      font-weight: 700;
      text-shadow: 0 0 0 transparent;
    }
    .kinetic-word.is-punct {
      color: inherit;
    }
    .kinetic-word[data-intensity="high"] {
      letter-spacing: 0.02em;
    }
    .block-title .kinetic-word {
      font-size: 0.9em;
      margin-right: 0.35rem;
    }
    .point-line .kinetic-word {
      font-size: 0.93em;
      margin-right: 0.22rem;
      opacity: 1;
    }
    .block-title,
    .point-line,
    .point-line .kinetic-word {
      text-rendering: geometricPrecision;
      -webkit-font-smoothing: antialiased;
      filter: none !important;
    }
    .kinetic-card {
      width: 100%;
      max-width: none;
      box-sizing: border-box;
      margin-left: 0;
      margin-right: 0;
    }
    .kinetic-card.is-overview-card {
      border-color: color-mix(in srgb, var(--accent-soft) 65%, #cbd5e1) !important;
      background: linear-gradient(150deg, rgba(15, 23, 42, 0.82), rgba(30, 41, 59, 0.86));
    }
    .visual-drawer {
      border: 1px solid rgba(148, 163, 184, 0.34);
      border-radius: 12px;
      padding: 8px 10px;
      margin: -6px 0 14px;
      background: rgba(2, 6, 23, 0.42);
      overflow: hidden;
    }
    .visual-drawer:not([open]) .deck-visuals {
      display: none !important;
    }
    .visual-drawer summary {
      cursor: pointer;
      user-select: none;
      font-size: 0.9rem;
      font-weight: 700;
      color: rgba(226, 232, 240, 0.92);
      letter-spacing: 0.01em;
      list-style: none;
    }
    .visual-drawer summary::-webkit-details-marker {
      display: none;
    }
    .visual-drawer summary::before {
      content: '▸';
      margin-right: 0.45rem;
      color: color-mix(in srgb, var(--accent-soft) 70%, #ffffff);
      transition: transform 180ms ease;
      display: inline-block;
    }
    .visual-drawer[open] summary::before {
      transform: rotate(90deg);
    }
    .deck-visuals {
      margin-top: 0.55rem;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
      gap: 12px;
    }
    .deck-visuals--single {
      grid-template-columns: minmax(320px, 1fr);
    }
    .deck-visual-card {
      border: 1px solid rgba(148, 163, 184, 0.34);
      border-radius: 14px;
      padding: 10px;
      margin: 0;
      background: rgba(2, 6, 23, 0.45);
      box-shadow: 0 8px 20px rgba(2, 6, 23, 0.35);
    }
    .deck-visual-card.is-single {
      justify-self: center;
      width: 100%;
      max-width: calc(100vw - 120px);
      margin-left: auto;
      margin-right: auto;
    }
    .deck-visual-img {
      display: block;
      width: 100%;
      height: auto;
      max-height: calc(100vh - 220px);
      object-fit: contain;
      border-radius: 10px;
      background: rgba(15, 23, 42, 0.75);
      image-rendering: auto;
    }
    .deck-visual-caption {
      margin-top: 0.45rem;
      font-size: 0.78rem;
      line-height: 1.3;
      color: rgba(226, 232, 240, 0.88);
    }

    /* Fallback: show intro slide if Reveal fails to initialize (e.g., blocked CDN). */
    body.deck-fallback .reveal .slides > section {
      display: none;
      position: relative;
      opacity: 1;
      visibility: visible;
    }
    body.deck-fallback .reveal .slides > section:first-child {
      display: block;
    }
    .fallback-nav {
      display: none;
      position: fixed;
      right: 22px;
      bottom: 20px;
      z-index: 9999;
      align-items: center;
      gap: 10px;
      background: rgba(2, 6, 23, 0.78);
      border: 1px solid rgba(148, 163, 184, 0.38);
      border-radius: 999px;
      padding: 8px 10px;
      backdrop-filter: blur(8px);
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
    }
    body.deck-fallback .fallback-nav {
      display: inline-flex;
    }
    .fallback-nav button {
      border: 0;
      border-radius: 999px;
      background: linear-gradient(120deg, var(--accent), var(--accent-soft));
      color: #f8fafc;
      padding: 8px 14px;
      font-size: 14px;
      font-weight: 700;
      cursor: pointer;
      line-height: 1;
    }
    .fallback-nav button:disabled {
      opacity: 0.45;
      cursor: not-allowed;
    }
    .fallback-page {
      font-size: 13px;
      color: var(--text-muted);
      min-width: 62px;
      text-align: center;
    }
  </style>
</head>
<body class="deck-fallback">
  <div class="reveal video-bg">
    <div class="slides">
      <section data-auto-animate class="industry-bg">
        <div class="h-full flex flex-col justify-center items-start px-20 py-16">
          <h1 class="cinema-fragment fade-up text-7xl font-black leading-[1.02] mb-5">${escapeHtml(model.deckTitle)}</h1>
          <p class="cinema-fragment sweep-in text-2xl font-semibold opacity-95 mb-4" data-motion="sweep-in">Arun Subramani</p>
          <p class="cinema-fragment fragment fade-up text-2xl opacity-90 mb-10" data-fragment-index="0">${escapeHtml(model.deckSubtitle)}</p>
          <p class="cinema-fragment fragment fade-up text-base opacity-75" data-fragment-index="1">Theme: ${model.industry.toUpperCase()} | Layout: 16:9 | Motion: GSAP + Reveal fragments</p>
        </div>
      </section>
      ${slidesHtml}
    </div>
  </div>
  <div id="fallback-nav" class="fallback-nav" aria-label="Fallback slide navigation">
    <button id="fallback-prev" type="button" aria-label="Previous slide">Prev</button>
    <span id="fallback-page" class="fallback-page">1 / 1</span>
    <button id="fallback-next" type="button" aria-label="Next slide">Next</button>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
  <script>
    const INTELLIGENT_STYLE_MIX = true;
    const AUTO_SCROLL_ENABLED = ${autoScroll ? "true" : "false"};
    const HAS_REVEAL = typeof Reveal === 'function';
    const HAS_GSAP = typeof gsap !== 'undefined';

    function startFallbackDeckNavigation() {
      const introSlide = document.querySelector('.reveal .slides > section.industry-bg');
      const generatedSlides = Array.from(document.querySelectorAll('.reveal .slides section[data-slide-index]'));
      const slides = Array.from(new Set([introSlide, ...generatedSlides].filter(Boolean)));
      if (!slides.length) return;
      const nav = document.getElementById('fallback-nav');
      const prevBtn = document.getElementById('fallback-prev');
      const nextBtn = document.getElementById('fallback-next');
      const pageLabel = document.getElementById('fallback-page');

      if (nav) {
        nav.style.display = 'inline-flex';
      }

      let index = 0;
      const render = () => {
        slides.forEach((slide, i) => {
          slide.style.display = i === index ? 'block' : 'none';
          slide.style.opacity = '1';
          slide.style.visibility = 'visible';
        });
        if (pageLabel) {
          pageLabel.textContent = (index + 1) + ' / ' + slides.length;
        }
        if (prevBtn) {
          prevBtn.disabled = index === 0;
        }
        if (nextBtn) {
          nextBtn.disabled = index === slides.length - 1;
        }
      };

      const go = (delta) => {
        const next = Math.max(0, Math.min(slides.length - 1, index + delta));
        if (next !== index) {
          index = next;
          render();
        }
      };

      let wheelAccum = 0;
      const wheelStepThreshold = 70;

      document.addEventListener('keydown', (event) => {
        const key = event.key;
        if (key === 'ArrowRight' || key === 'PageDown' || key === ' ') {
          event.preventDefault();
          go(1);
        } else if (key === 'ArrowLeft' || key === 'PageUp') {
          event.preventDefault();
          go(-1);
        } else if (key === 'Home') {
          event.preventDefault();
          index = 0;
          render();
        } else if (key === 'End') {
          event.preventDefault();
          index = slides.length - 1;
          render();
        }
      });

      document.addEventListener(
        'wheel',
        (event) => {
          wheelAccum += event.deltaY;
          if (wheelAccum >= wheelStepThreshold) {
            go(1);
            wheelAccum = 0;
          } else if (wheelAccum <= -wheelStepThreshold) {
            go(-1);
            wheelAccum = 0;
          }
        },
        { passive: true }
      );

      if (prevBtn) {
        prevBtn.addEventListener('click', () => go(-1));
      }
      if (nextBtn) {
        nextBtn.addEventListener('click', () => go(1));
      }

      render();
    }

    function archetypes() {
      return {
        calm: { titleStagger: 0.046, pointStagger: 0.0078, titleEase: 'power2.out', itemEase: 'sine.out', drift: 0.85, scrollDelay: 1.6, titleInX: -16, titleOutX: 18, cardInY: 16, cardOutY: -16, cardScaleIn: 0.97, cardScaleOut: 1.01 },
        process: { titleStagger: 0.032, pointStagger: 0.0052, titleEase: 'power3.out', itemEase: 'power2.out', drift: 1.2, scrollDelay: 1.1, titleInX: -34, titleOutX: 36, cardInY: 24, cardOutY: -26, cardScaleIn: 0.94, cardScaleOut: 1.04 },
        impact: { titleStagger: 0.024, pointStagger: 0.0039, titleEase: 'back.out(1.35)', itemEase: 'power3.out', drift: 1.55, scrollDelay: 0.85, titleInX: -52, titleOutX: 56, cardInY: 34, cardOutY: -38, cardScaleIn: 0.89, cardScaleOut: 1.08 },
        caution: { titleStagger: 0.028, pointStagger: 0.0046, titleEase: 'expo.out', itemEase: 'power2.out', drift: 1.25, scrollDelay: 1.0, titleInX: -42, titleOutX: 44, cardInY: 28, cardOutY: -30, cardScaleIn: 0.92, cardScaleOut: 1.05 },
        qa: { titleStagger: 0.022, pointStagger: 0.0036, titleEase: 'back.out(1.7)', itemEase: 'power4.out', drift: 1.7, scrollDelay: 0.75, titleInX: -58, titleOutX: 64, cardInY: 40, cardOutY: -44, cardScaleIn: 0.86, cardScaleOut: 1.1 }
      };
    }

    function mixProfile(weights, idx) {
      const a = archetypes();
      const keys = Object.keys(weights).filter((k) => weights[k] > 0);
      const total = keys.reduce((s, k) => s + weights[k], 0) || 1;
      const out = {
        name: 'smart-mix',
        titleStagger: 0,
        pointStagger: 0,
        titleEase: a.calm.titleEase,
        itemEase: a.calm.itemEase,
        drift: 0,
        scrollDelay: 0,
        titleInX: 0,
        titleOutX: 0,
        cardInY: 0,
        cardOutY: 0,
        cardScaleIn: 0,
        cardScaleOut: 0
      };

      for (const k of keys) {
        const w = weights[k] / total;
        const src = a[k];
        out.titleStagger += src.titleStagger * w;
        out.pointStagger += src.pointStagger * w;
        out.drift += src.drift * w;
        out.scrollDelay += src.scrollDelay * w;
        out.titleInX += src.titleInX * w;
        out.titleOutX += src.titleOutX * w;
        out.cardInY += src.cardInY * w;
        out.cardOutY += src.cardOutY * w;
        out.cardScaleIn += src.cardScaleIn * w;
        out.cardScaleOut += src.cardScaleOut * w;
      }

      const easeKeys = keys.length ? keys : ['calm'];
      const picked = easeKeys[idx % easeKeys.length];
      out.titleEase = a[picked].titleEase;
      out.itemEase = a[picked].itemEase;
      out.name = 'smart-' + picked;
      return out;
    }

    function classifySlideSemantics(slideEl) {
      const text = (slideEl?.innerText || '').toLowerCase();
      const cards = slideEl?.querySelectorAll('.kinetic-card').length || 0;
      const points = slideEl?.querySelectorAll('.point-line').length || 0;
      const words = text.split(/\s+/).filter(Boolean).length;
      const avgWordsPerPoint = points ? words / points : words;

      const weights = {
        calm: 0.2,
        process: 0.2,
        impact: 0.2,
        caution: 0.2,
        qa: 0.2
      };

      if (/[?]|q\s*&\s*a|question|talking point/.test(text)) weights.qa += 1.15;
      if (/step\s*[0-9]+|flow|pipeline|loop|sequence|process|\u2192|->/.test(text)) weights.process += 1.1;
      if (/pitfall|risk|warning|clarification|avoid|don't|do not|caution/.test(text)) weights.caution += 1.2;
      if (/key concept|important|must|critical|core|overview|introduction/.test(text)) weights.impact += 0.95;
      if (/definition|means|is\s+a|is\s+an|summary/.test(text)) weights.calm += 0.85;

      if (cards >= 5 || points >= 16 || avgWordsPerPoint > 18) {
        weights.calm += 0.85;
        weights.impact -= 0.22;
        weights.qa -= 0.16;
      }

      if (points <= 6 && avgWordsPerPoint < 13) {
        weights.impact += 0.52;
      }

      if (!INTELLIGENT_STYLE_MIX) {
        return { calm: 0.2, process: 0.3, impact: 0.3, caution: 0.1, qa: 0.1 };
      }

      return weights;
    }

    function getSlideProfile(slideEl) {
      const idx = Number(slideEl?.getAttribute('data-slide-index') ?? '0') || 0;
      const weights = classifySlideSemantics(slideEl);
      return mixProfile(weights, idx);
    }

    function animateOverflowViewport(slideEl, profile) {
      if (!HAS_GSAP) return;
      if (!slideEl) return;
      const viewport = slideEl.querySelector('.content-viewport');
      if (!viewport) return;
      const maxScroll = viewport.scrollHeight - viewport.clientHeight;
      gsap.killTweensOf(viewport);
      if (!AUTO_SCROLL_ENABLED || maxScroll < 28) return;

      const duration = Math.max(7, maxScroll / 95);
      gsap.to(viewport, {
        scrollTop: maxScroll,
        duration,
        ease: 'sine.inOut',
        yoyo: true,
        repeat: -1,
        repeatDelay: 1,
        delay: profile.scrollDelay
      });
    }

    function stopOverflowViewport(slideEl) {
      if (!HAS_GSAP) return;
      if (!slideEl) return;
      const viewport = slideEl.querySelector('.content-viewport');
      if (viewport) {
        gsap.killTweensOf(viewport);
      }
    }

    function clearPendingSlideTimers(slideEl) {
      if (!slideEl) return;
      if (slideEl.__dockCall && typeof slideEl.__dockCall.kill === 'function') {
        slideEl.__dockCall.kill();
      }
      slideEl.__dockCall = null;

      if (slideEl.__dockTimer) {
        clearTimeout(slideEl.__dockTimer);
      }
      slideEl.__dockTimer = null;

      if (slideEl.__failsafeTimer) {
        clearTimeout(slideEl.__failsafeTimer);
      }
      slideEl.__failsafeTimer = null;
    }

    function animateSlide(slideEl) {
      if (!HAS_GSAP) return;
      if (!slideEl) return;
      clearPendingSlideTimers(slideEl);
      const profile = getSlideProfile(slideEl);
      const cards = Array.from(slideEl.querySelectorAll('.kinetic-card'));
      const titleCenterEl = slideEl.querySelector('.kinetic-title-center');
      const titleTopEl = slideEl.querySelector('.kinetic-title-top');
      const viewportEl = slideEl.querySelector('.content-viewport');
      const titleCenterWords = Array.from(slideEl.querySelectorAll('.kinetic-title-center .kinetic-word'));
      const tl = gsap.timeline({ defaults: { overwrite: 'auto' } });

      slideEl.setAttribute('data-section-closed', '0');
      if (cards.length) {
        gsap.set(cards, { opacity: 0, y: 0, scale: 1 });
      }

      if (titleCenterEl) {
        gsap.set(titleCenterEl, { opacity: 1, y: 0, x: 0, scale: 1 });
      }
      if (titleTopEl) {
        gsap.set(titleTopEl, { opacity: 0, y: 20 });
      }

      if (viewportEl) {
        viewportEl.style.transition = 'none';
        viewportEl.style.opacity = '0';
        viewportEl.style.transform = 'translateY(26px)';
      }

      if (titleCenterWords.length) {
        tl.fromTo(
          titleCenterWords,
          {
            opacity: 0,
            x: profile.titleInX,
            y: 62,
            rotateZ: (i) => (i % 2 === 0 ? -6 : 6),
            filter: 'blur(8px)',
            scale: 0.9
          },
          {
            opacity: 1,
            x: 0,
            y: 0,
            rotateZ: 0,
            filter: 'blur(0px)',
            scale: 1,
            duration: (i) => 0.42 + (i % 5) * 0.06,
            stagger: { each: profile.titleStagger, from: 'start' },
            ease: profile.titleEase
          }
        );
      }

      if (cards.length) {
        tl.fromTo(
          cards,
          {},
          {
            opacity: 1,
            duration: 0.56,
            stagger: { each: Math.max(0.02, profile.pointStagger * 2.2), from: 'start' },
            ease: profile.itemEase
          },
          '+=0.12'
        );
      }

      // Deterministic dock sequence: center title -> top title -> content reveal.
      if (titleCenterEl) {
        tl.to(
          titleCenterEl,
          {
            yPercent: -68,
            opacity: 0,
            duration: 0.62,
            ease: 'power2.inOut'
          },
          0.78
        );
      }
      if (titleTopEl) {
        tl.to(
          titleTopEl,
          {
            opacity: 1,
            y: 0,
            duration: 0.58,
            ease: 'power2.out'
          },
          0.86
        );
      }
      if (viewportEl) {
        tl.call(() => {
          viewportEl.style.transition = 'opacity 450ms ease, transform 450ms ease';
          viewportEl.style.opacity = '1';
          viewportEl.style.transform = 'translateY(0px)';
        }, undefined, 0.9);
      }

      if (cards.length) {
        tl.to(
          cards,
          {
            boxShadow: '0 14px 38px rgba(0, 0, 0, 0.42)',
            duration: 0.35,
            stagger: { each: profile.pointStagger, from: 'start' },
            ease: 'power1.out'
          },
          '-=0.2'
        );
      }

      if (titleCenterWords.length) {
        tl.to(
          titleCenterWords,
          {
            y: (i) => (i % 2 === 0 ? -profile.drift : profile.drift),
            repeat: 1,
            yoyo: true,
            duration: 0.45,
            stagger: { each: profile.pointStagger * 2.4, from: 'start' },
            ease: 'sine.inOut'
          },
          '-=0.08'
        );
      }

      animateOverflowViewport(slideEl, profile);
    }

    function animateSectionClosure(slideEl) {
      if (!HAS_GSAP) return;
      if (!slideEl || slideEl.getAttribute('data-section-closed') === '1') return;
      slideEl.setAttribute('data-section-closed', '1');

      const profile = getSlideProfile(slideEl);
      const overviewCards = Array.from(slideEl.querySelectorAll('.kinetic-card.is-overview-card'));
      if (!overviewCards.length) return;

      gsap.to(overviewCards, {
        opacity: 0,
        y: profile.cardOutY,
        scale: profile.cardScaleOut,
        filter: 'blur(3px)',
        duration: 0.34,
        stagger: { each: Math.max(0.01, profile.pointStagger), from: 'end' },
        ease: 'power2.in'
      });
    }

    function animateSlideOut(slideEl) {
      if (!HAS_GSAP) return;
      if (!slideEl) return;
      clearPendingSlideTimers(slideEl);
      const profile = getSlideProfile(slideEl);
      const cards = Array.from(slideEl.querySelectorAll('.kinetic-card'));
      const titleCenterEl = slideEl.querySelector('.kinetic-title-center');
      const titleTopEl = slideEl.querySelector('.kinetic-title-top');
      const viewportEl = slideEl.querySelector('.content-viewport');
      const titleWords = Array.from(slideEl.querySelectorAll('.kinetic-title .kinetic-word'));
      const allFragments = Array.from(slideEl.querySelectorAll('.cinema-fragment'));

      const tweenTargets = [...cards, ...titleWords, ...allFragments, titleCenterEl, titleTopEl].filter(Boolean);
      if (tweenTargets.length) {
        gsap.killTweensOf(tweenTargets);
      }

      const outTl = gsap.timeline({ defaults: { overwrite: 'auto' } });
      if (cards.length) {
        outTl.to(
          cards,
          {
            opacity: 0,
            y: profile.cardOutY,
            scale: profile.cardScaleOut,
            filter: 'blur(3px)',
            duration: 0.26,
            stagger: { each: Math.max(0.012, profile.pointStagger * 1.1), from: 'end' },
            ease: 'power2.in'
          },
          0.02
        );
      }
      if (titleWords.length) {
        outTl.to(
          titleWords,
          {
            opacity: 0,
            x: profile.titleOutX,
            y: -22,
            scale: 1.05,
            filter: 'blur(5px)',
            duration: 0.24,
            stagger: { each: Math.max(0.01, profile.pointStagger * 1.8), from: 'end' },
            ease: 'power2.in'
          },
          0.05
        );
      }

      if (titleTopEl) {
        outTl.to(
          titleTopEl,
          {
            opacity: 0,
            y: -24,
            duration: 0.2,
            ease: 'power2.in'
          },
          0.02
        );
      }

      if (titleCenterEl) {
        outTl.to(
          titleCenterEl,
          {
            opacity: 0,
            y: -24,
            duration: 0.2,
            ease: 'power2.in'
          },
          0.02
        );
      }

      if (viewportEl) {
        viewportEl.style.transition = 'none';
        viewportEl.style.opacity = '1';
        viewportEl.style.transform = 'translateY(0px)';
      }

      const resetTargets = [...cards, ...titleWords, ...allFragments];
      if (resetTargets.length) {
        outTl.set(
          resetTargets,
          { opacity: 0, clearProps: 'transform,filter' },
          '+=0.02'
        );
      }
    }

    function resetCardProgression(slideEl) {
      if (!slideEl) return;
      const cards = Array.from(slideEl.querySelectorAll('.kinetic-card'));
      cards.forEach((card) => {
        if (HAS_GSAP) {
          gsap.killTweensOf(card);
          gsap.set(card, {
            clearProps: 'opacity,transform,maxHeight,marginTop,marginBottom,paddingTop,paddingBottom,borderTopWidth,borderBottomWidth,overflow'
          });
        }
        card.classList.remove('is-past-card');
        card.removeAttribute('aria-hidden');
      });
    }

    function updateCardProgression(fragmentEl) {
      if (!fragmentEl) return;
      if (!fragmentEl.classList.contains('kinetic-card')) return;
      const slideEl = fragmentEl.closest('section');
      if (!slideEl) return;

      const activeIndex = Number(fragmentEl.getAttribute('data-card-index') ?? '-1');
      if (Number.isNaN(activeIndex) || activeIndex < 0) return;

      const cards = Array.from(slideEl.querySelectorAll('.kinetic-card'));
      cards.forEach((card) => {
        const idx = Number(card.getAttribute('data-card-index') ?? '-1');
        if (Number.isNaN(idx)) return;

        if (idx < activeIndex) {
          card.classList.add('is-past-card');
          card.setAttribute('aria-hidden', 'true');
          if (HAS_GSAP) {
            gsap.killTweensOf(card);
            const hideTl = gsap.timeline({ defaults: { overwrite: 'auto' } });
            hideTl.to(card, {
              opacity: 0,
              y: -12,
              scale: 0.99,
              duration: 0.34,
              ease: 'power2.out',
              onStart: () => {
                card.style.overflow = 'hidden';
              }
            });
            hideTl.to(
              card,
              {
                maxHeight: 0,
                marginTop: 0,
                marginBottom: 0,
                paddingTop: 0,
                paddingBottom: 0,
                borderTopWidth: 0,
                borderBottomWidth: 0,
                duration: 0.24,
                ease: 'power1.in'
              },
              '-=0.08'
            );
          }
        } else {
          card.classList.remove('is-past-card');
          card.removeAttribute('aria-hidden');
          if (HAS_GSAP) {
            gsap.killTweensOf(card);
            const showTl = gsap.timeline({ defaults: { overwrite: 'auto' } });
            showTl.to(card, {
              opacity: 1,
              y: 0,
              scale: 1,
              duration: 0.28,
              ease: 'power2.out'
            });
            showTl.to(
              card,
              {
              maxHeight: 1400,
              marginTop: 0,
              marginBottom: 20,
              paddingTop: 24,
              paddingBottom: 24,
              borderTopWidth: 1,
              borderBottomWidth: 1,
              duration: 0.22,
              ease: 'power2.out',
              onComplete: () => {
                card.style.overflow = '';
              }
              },
              0
            );
          }
        }
      });
    }

    function resetScrollableRegions(slideEl) {
      if (!slideEl) return;
      const viewport = slideEl.querySelector('.content-viewport');
      if (viewport) {
        if (HAS_GSAP) {
          gsap.killTweensOf(viewport);
        }
        viewport.scrollTop = 0;
      }
    }

    if (!HAS_REVEAL) {
      startFallbackDeckNavigation();
    } else {
      const reveal = new Reveal({
        hash: true,
        transition: 'slide',
        backgroundTransition: 'fade',
        fragments: true,
        width: 1600,
        height: 900,
        margin: 0.04,
        minScale: 0.2,
        maxScale: 1.5,
        mouseWheel: true,
        controls: true,
        progress: true,
        center: false
      });

      const stabilizeLayout = () => {
        try {
          reveal.layout();
        } catch {
          // no-op: reveal may not be fully initialized yet
        }
      };

      reveal
        .initialize()
        .then(() => {
          document.body.classList.remove('deck-fallback');
          stabilizeLayout();
          resetScrollableRegions(reveal.getCurrentSlide());
          resetCardProgression(reveal.getCurrentSlide());
          animateSlide(reveal.getCurrentSlide());
        })
        .catch(() => {
          startFallbackDeckNavigation();
        });

      reveal.on('slidechanged', (event) => {
        stopOverflowViewport(event.previousSlide);
        animateSlideOut(event.previousSlide);
        stabilizeLayout();
        resetScrollableRegions(event.currentSlide);
        resetCardProgression(event.currentSlide);
        animateSlide(event.currentSlide);
      });

      reveal.on('fragmentshown', (event) => {
        stabilizeLayout();
        updateCardProgression(event?.fragment);
        const slideEl = event?.fragment?.closest('section');
        if (!slideEl) return;
        const fragments = slideEl.querySelectorAll('.fragment');
        const visible = slideEl.querySelectorAll('.fragment.visible');
        if (fragments.length > 0 && visible.length === fragments.length) {
          animateSectionClosure(slideEl);
        }
      });

      window.addEventListener('focus', stabilizeLayout);
      document.addEventListener('visibilitychange', () => {
        if (document.visibilityState === 'visible') stabilizeLayout();
      });
    }
  </script>
</body>
</html>`;
}
