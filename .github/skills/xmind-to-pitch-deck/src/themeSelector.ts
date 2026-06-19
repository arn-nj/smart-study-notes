import type { Industry } from "./types.js";

export type Theme = {
  industry: Industry;
  bgGradient: string;
  accent: string;
  accentSoft: string;
  textMain: string;
  textMuted: string;
  panel: string;
};

const THEMES: Record<Industry, Theme> = {
  ai: {
    industry: "ai",
    bgGradient: "from-slate-950 via-indigo-950 to-cyan-950",
    accent: "#60a5fa",
    accentSoft: "#a5b4fc",
    textMain: "#f8fafc",
    textMuted: "#cbd5e1",
    panel: "bg-slate-900/70 border-slate-700"
  },
  saas: {
    industry: "saas",
    bgGradient: "from-slate-950 via-sky-950 to-emerald-950",
    accent: "#22d3ee",
    accentSoft: "#86efac",
    textMain: "#f8fafc",
    textMuted: "#d1d5db",
    panel: "bg-slate-900/65 border-slate-700"
  },
  finance: {
    industry: "finance",
    bgGradient: "from-zinc-950 via-emerald-950 to-zinc-950",
    accent: "#10b981",
    accentSoft: "#6ee7b7",
    textMain: "#f9fafb",
    textMuted: "#d1d5db",
    panel: "bg-zinc-900/70 border-zinc-700"
  },
  healthcare: {
    industry: "healthcare",
    bgGradient: "from-slate-950 via-cyan-950 to-teal-950",
    accent: "#06b6d4",
    accentSoft: "#67e8f9",
    textMain: "#f0fdfa",
    textMuted: "#bae6fd",
    panel: "bg-slate-900/70 border-cyan-900"
  },
  education: {
    industry: "education",
    bgGradient: "from-indigo-950 via-slate-950 to-violet-950",
    accent: "#8b5cf6",
    accentSoft: "#c4b5fd",
    textMain: "#f5f3ff",
    textMuted: "#ddd6fe",
    panel: "bg-slate-900/70 border-indigo-800"
  },
  retail: {
    industry: "retail",
    bgGradient: "from-rose-950 via-slate-950 to-amber-950",
    accent: "#f59e0b",
    accentSoft: "#fdba74",
    textMain: "#fff7ed",
    textMuted: "#fed7aa",
    panel: "bg-zinc-900/70 border-amber-900"
  },
  gaming: {
    industry: "gaming",
    bgGradient: "from-fuchsia-950 via-slate-950 to-indigo-950",
    accent: "#e879f9",
    accentSoft: "#c4b5fd",
    textMain: "#faf5ff",
    textMuted: "#ddd6fe",
    panel: "bg-slate-900/70 border-fuchsia-900"
  },
  general: {
    industry: "general",
    bgGradient: "from-slate-950 via-slate-900 to-slate-800",
    accent: "#38bdf8",
    accentSoft: "#a5f3fc",
    textMain: "#f8fafc",
    textMuted: "#cbd5e1",
    panel: "bg-slate-900/65 border-slate-700"
  }
};

const KEYWORDS: Array<{ industry: Industry; terms: string[] }> = [
  { industry: "finance", terms: ["finance", "fintech", "bank", "invest", "capital", "equity"] },
  { industry: "healthcare", terms: ["health", "medical", "hospital", "clinical", "patient"] },
  { industry: "education", terms: ["education", "learning", "course", "student", "school"] },
  { industry: "retail", terms: ["retail", "commerce", "store", "consumer", "marketplace"] },
  { industry: "gaming", terms: ["game", "gaming", "esports", "player"] },
  { industry: "saas", terms: ["saas", "b2b", "crm", "subscription", "platform"] },
  { industry: "ai", terms: ["ai", "llm", "model", "machine learning", "agent"] }
];

export function detectIndustry(text: string): Industry {
  const lower = text.toLowerCase();
  for (const row of KEYWORDS) {
    if (row.terms.some((term) => lower.includes(term))) {
      return row.industry;
    }
  }
  return "general";
}

export function getTheme(industry: Industry): Theme {
  return THEMES[industry] ?? THEMES.general;
}
