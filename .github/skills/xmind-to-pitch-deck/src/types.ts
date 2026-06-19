export type TopicNode = {
  title: string;
  children: TopicNode[];
  visuals?: SlideVisual[];
};

export type SlideBlock = {
  title: string;
  points: string[];
};

export type SlideVisual = {
  src: string;
  alt: string;
};

export type DeckSlide = {
  id: string;
  title: string;
  subtitle?: string;
  blocks: SlideBlock[];
  visuals?: SlideVisual[];
  blockVisuals?: Record<string, SlideVisual[]>;
};

export type DeckModel = {
  deckTitle: string;
  deckSubtitle: string;
  industry: Industry;
  slides: DeckSlide[];
};

export type Industry =
  | "ai"
  | "saas"
  | "finance"
  | "healthcare"
  | "education"
  | "retail"
  | "gaming"
  | "general";
