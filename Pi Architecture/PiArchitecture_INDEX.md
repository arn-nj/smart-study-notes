# Pi Architecture — Topic Index

> Quick-navigation index for all pages, concepts, and review items.

## Table of Contents
| # | Page Title | Difficulty | Topics Covered |
|---|-----------|-----------|----------------|
| 1 | Introduction — What is Pi? | Easy | Pi, PyCore, PyInteractive, RPC Mode |
| 2 | The Agentic Loop — Core Engine Overview | Medium | Agent Loop, Context Window, Tool Call, Turn |
| 3 | Context Initialization — Building the System Prompt | Medium | system.md, append-system.md, agents.md, Skill description |
| 4 | Context Transformation — When and How Pi Compacts | Medium | checkCompaction, Compaction trigger, Token estimation, Compacted summary |
| 5 | The LLM Call & Tool Execution Loop | Medium | Tool call, Tool result, Provider, Turn |
| 6 | Sessions & Memory — JSONL Storage | Easy | JSONL, Session file, Working directory mapping, Append-only |
| 7 | Session Tree Structure — Forking Conversations | Medium | parentId, Fork, /tree, Branch |
| 8 | Core Tools — The Minimal Toolbox | Easy | read, bash, edit, write |
| 9 | Extensions — Extending Pi's Capabilities | Medium | Extension, Event subscription, Tool registration, Modular design |
| 10 | System Prompt Deep Dive — What Pi Tells Itself | Easy | System prompt, Skills markup, append-system.md, system.md |
| 11 | CLI Entry Point — From Command to Agent Session | Medium | client.ts, main.ts, Interactive mode, RPC mode |
| 12 | Terminal User Interface — The TUI Design | Medium | Custom TUI, Component-based, Event subscription, No flicker |
| 13 | Skills System — How Pi Reads and Uses Skills | Hard | Skill, Skill invocation, Lazy loading, Custom commands |

## All Key Concepts (A–Z)
- **/tree** — TUI command to visualize and navigate all conversation branches *(Page 7)*
- **Agent Loop** — The repeating cycle that processes every user message *(Page 2)*
- **agents.md** — Markdown file Pi auto-loads — use for persistent project context *(Page 3)*
- **Append-only** — New messages are always appended to end — never overwrites old lines *(Page 6)*
- **append-system.md** — Place in `.pi/` to ADD to (not replace) the default prompt *(Page 3, Page 10)*
- **bash** — Execute arbitrary shell commands *(Page 8)*
- **Branch** — A path through the conversation tree; multiple can stem from one parent *(Page 7)*
- **checkCompaction** — Pi's function to decide if history needs to be compressed *(Page 4)*
- **client.ts** — Entry point; receives command, delegates to main *(Page 11)*
- **Compacted summary** — Structured checkpoint stored instead of raw message history *(Page 4)*
- **Compaction trigger** — After agent turn ends OR before next user prompt *(Page 4)*
- **Component-based** — Each component = own render logic + input handling + dynamic updates *(Page 12)*
- **Context Window** — The combined token budget holding system prompt + history + tools *(Page 2)*
- **Custom commands** — Slash commands that are simple prompt replacements — fully expanded at TUI layer *(Page 13)*
- **Custom TUI** — Built entirely in TypeScript for Pi — no external TUI libraries *(Page 12)*
- **edit** — Apply targeted changes to an existing file *(Page 8)*
- **Event subscription** — Register to fire code when specific loop events occur *(Page 9, Page 12)*
- **Extension** — A TypeScript package that plugs into Pi's event system *(Page 9)*
- **Fork** — Start a new branch from any past message; both branches coexist in the file *(Page 7)*
- **Interactive mode** — Full TUI experience *(Page 11)*
- **JSONL** — JSON Lines — one JSON object per line; easy to append without parsing the whole file *(Page 6)*
- **Lazy loading** — Full skill content loaded by LLM on demand via read tool *(Page 13)*
- **main.ts** — Parses args, loads config, loads extensions, creates session, runs mode *(Page 11)*
- **Modular design** — Pi's architecture explicitly supports this — no hacks needed *(Page 9)*
- **No flicker** — Each component redraws independently — no full screen clear/redraw *(Page 12)*
- **parentId** — Reference to the previous message — creates the tree structure *(Page 7)*
- **Pi** — A minimalist AI coding agent, entirely custom-built, no external frameworks *(Page 1)*
- **Provider** — Which LLM serves the call — can be OpenAI, Anthropic, Kimi, Minimax, etc. *(Page 5)*
- **PyCore** — The agentic loop — handles conversations, tools, sessions *(Page 1)*
- **PyInteractive** — The interface layer — TUI, CLI entry, skills, extensions *(Page 1)*
- **read** — Read any file from the filesystem *(Page 8)*
- **Read-only mode** — `--tools read,grep,find` — useful for programmatic/RPC use *(Page 8)*
- **RPC Mode** — Pi can also be called programmatically, not just interactively *(Page 1)*
- **RPC mode** — Programmatic API calls to Pi *(Page 11)*
- **Session file** — `.jsonl` file in `~/.pi/agent/sessions/<directory>/` *(Page 6)*
- **Skill** — A `.md` file with detailed instructions — only description in system prompt *(Page 13)*
- **Skill description** — Short summary loaded into context; full skill content loaded only when invoked *(Page 3)*
- **Skill invocation** — `/skill:<name>` — intercepted by TUI, not passed raw to PyCore *(Page 13)*
- **Skills markup** — Skills are embedded with XML-like tags in the prompt — this allows TUI to parse them *(Page 10)*
- **STDIO mode** — Pass a prompt via CLI arg; Pi runs once and exits *(Page 11)*
- **System prompt** — The root instruction set passed to the LLM at every turn *(Page 10)*
- **system.md** — Place in `.pi/` to override the default system prompt *(Page 3, Page 10)*
- **Token estimation** — Uses LLM response usage fields (input + output + cache) *(Page 4)*
- **Tool Call** — A structured request from the LLM to use a tool (e.g. read a file) *(Page 2)*
- **Tool call** — Structured JSON returned by LLM specifying which tool to invoke and with what args *(Page 5)*
- **Tool registration** — Add entirely new tools (e.g. web search, browser, API calls) *(Page 9)*
- **Tool result** — The output of executing that tool, appended back to context *(Page 5)*
- **Turn** — One complete pass through the loop, ending in a final reply *(Page 2, Page 5)*
- **Working directory mapping** — Sessions are organized by the directory Pi was run in *(Page 6)*
- **write** — Create or overwrite a file *(Page 8)*

## All Flashcard Questions
| Q | A | Page |
|---|---|------|
| What is Pi's design philosophy? | Minimalist, custom-built, no external agent libraries | 1 |
| What is PyCore? | The agentic loop engine (sessions, tools, LLM calls) | 1 |
| What is PyInteractive? | The interactive layer: TUI, CLI, skills, and extensions | 1 |
| Can Pi be used programmatically? | Yes — via RPC or STDIO | 1 |
| What are the 3 phases of Pi's agent loop? | Init Context → Transform Context → LLM Call | 2 |
| What happens after a tool call? | Result is fed back to LLM; loop continues | 2 |
| When does the loop end a turn? | When LLM emits a final reply (no more tool calls) | 2 |
| What 6 items make up Pi's context? | System prompt, agents.md, skill descs, tool descs, history, current message | 3 |
| How do you extend the system prompt without replacing it? | Create `append-system.md` in `.pi/` | 3 |
| What goes into context for skills? | Only the description — full content is loaded when skill is invoked | 3 |
| What triggers checkCompaction? | After agent turn ends + before each user prompt | 4 |
| How does Pi estimate tokens? | From LLM usage fields in the response | 4 |
| What does compaction output contain? | Goal, constraints, progress, decisions, next steps, critical context | 4 |
| What can the LLM return in Phase 3? | A tool call OR a final text reply | 5 |
| What happens after a tool is executed? | Result is appended to context and LLM is called again | 5 |
| What ends a turn? | LLM returns a reply without requesting any tool call | 5 |
| What format are sessions stored in? | JSONL (one JSON object per line) | 6 |
| How are session directories named? | Based on the working directory path | 6 |
| What's the advantage of JSONL for sessions? | Append new messages without rewriting the whole file | 6 |
| How does Pi create a session tree? | Every message has parentId pointing to its parent | 7 |
| How do you navigate the tree in Pi? | Use the /tree command | 7 |
| Can you have multiple forks in one session? | Yes — unlimited forks, all in the same JSONL file | 7 |
| What are Pi's 4 default tools? | read, bash, edit, write | 8 |
| Why are grep and find disabled? | They're designed for read-only/RPC mode only | 8 |
| How do you add web search to Pi? | Install it as an extension | 8 |
| What can extensions do? | Add tools, subscribe events, add commands, update prompt, render messages | 9 |
| What language are extensions written in? | TypeScript | 9 |
| Why be careful with third-party extensions? | They execute code on your system | 9 |
| How is Pi's system prompt structure notable? | ~20 lines — extremely minimalist | 10 |
| What markup wraps skill listings in the prompt? | XML-like skill/skills tags | 10 |
| What's the difference between system.md and append-system.md? | system.md replaces; append-system.md adds | 10 |
| What does client.ts do? | Receives pi command, sets process title, calls main() | 11 |
| What does main.ts do? | Parse args → resolve config → load extensions → create agent session → run mode | 11 |
| What are Pi's 3 run modes? | Interactive (TUI), RPC, STDIO | 11 |
| Is Pi's TUI based on any framework? | No — completely custom TypeScript | 12 |
| What makes Pi's TUI component-based? | Each component owns its own render, input, and update logic | 12 |
| How do components react to agent events? | By subscribing to events emitted by the agent loop | 12 |
| What does the system prompt contain for skills? | Only name and description — not full content | 13 |
| How does Pi load full skill content? | LLM uses read tool on the skill's file location | 13 |
| How are custom /commands different from skills? | Commands are expanded to full text at TUI layer immediately | 13 |

## All Checkpoint Items
- [ ] I can explain what Pi is and why its two-part design is notable in one sentence *(Page 1)*
- [ ] I can draw the 3-phase agentic loop without referring to notes *(Page 2)*
- [ ] I can list the 6 layers of Pi's context initialization in order *(Page 3)*
- [ ] I can explain when and why Pi compacts its context *(Page 4)*
- [ ] I can trace a multi-step task through the tool execution loop *(Page 5)*
- [ ] I can explain where sessions are stored and why JSONL is used *(Page 6)*
- [ ] I can explain how parentId creates a tree structure from a flat JSONL file *(Page 7)*
- [ ] I can name Pi's 4 default tools and explain when to use each *(Page 8)*
- [ ] I can list 5 things extensions can do and explain why they're safe or not *(Page 9)*
- [ ] I can describe Pi's system prompt structure and explain how to extend it *(Page 10)*
- [ ] I can describe the startup sequence from `pi` command to running agent session *(Page 11)*
- [ ] I can explain Pi's TUI design and why it's notable *(Page 12)*
- [ ] I can trace the full skill invocation path from user command to LLM execution *(Page 13)*

## Quick-Find by Topic
### Architecture & Agent Loop
- Page 1: Introduction — What is Pi? — Why Pi is a beautifully minimalist AI coding agent and why understanding its architecture helps you build your own.
- Page 2: The Agentic Loop — Core Engine Overview — The exact sequence of steps Pi executes every time you send a message — the beating heart of any AI agent.
### Context, Compaction & Memory
- Page 3: Context Initialization — Building the System Prompt — Exactly what gets assembled into Pi's context before every LLM call, and how to extend it yourself.
- Page 4: Context Transformation — When and How Pi Compacts — How Pi decides when to compress conversation history to stay within the model's context window.
- Page 6: Sessions & Memory — JSONL Storage — Where and how Pi stores your conversation sessions — and why JSONL is the ideal format for this.
- Page 7: Session Tree Structure — Forking Conversations — Why Pi sessions are a tree (not a list) and how the `parentId` field enables conversation forking.
### Tools, Extensions & Skills
- Page 8: Core Tools — The Minimal Toolbox — Pi's deliberately minimal tool set — 4 core tools — and why this is enough for most coding tasks.
- Page 9: Extensions — Extending Pi's Capabilities — How Pi's extension system lets you add new tools, subscribe to events, and modify the agent without touching core code.
- Page 10: System Prompt Deep Dive — What Pi Tells Itself — What Pi's default system prompt contains and the exact mechanisms to customize it.
- Page 13: Skills System — How Pi Reads and Uses Skills — The clever two-step process by which Pi makes skill descriptions available to the LLM while keeping full content lazy-loaded.
### Runtime, CLI & TUI
- Page 5: The LLM Call & Tool Execution Loop — What actually happens when Pi calls the LLM — how tool calls work and how results flow back.
- Page 11: CLI Entry Point — From Command to Agent Session — How typing `pi` in a terminal becomes a running agent session — the two files that make it work.
- Page 12: Terminal User Interface — The TUI Design — Why Pi's TUI is notable, how it's built, and the component model that makes it fast and flicker-free.

## Spaced Repetition Master Schedule
| Day | Review Item | Page |
|-----|-------------|------|
| 1 | Name the 2 parts of Pi and their responsibilities | 1 |
| 3 | Explain what "custom-built" means for Pi's architecture | 1 |
| 7 | Draw the two-box Pi architecture diagram from memory | 1 |
| 14 | Compare Pi to an agent that uses OpenAI Agents SDK | 1 |
| 30 | Teach the two-layer Pi design to someone unfamiliar with agents | 1 |
| 1 | Draw the 3-phase loop from memory | 2 |
| 3 | Describe what "Transform Context" does | 2 |
| 7 | Trace through a "refactor a file" request using the loop steps | 2 |
| 14 | Explain why tool results go back to the LLM | 2 |
| 30 | Build a diagram of the loop with edge cases (compaction, multi-tool) | 2 |
| 1 | List the 6 layers of Pi's context from memory | 3 |
| 3 | Explain the difference between `system.md` and `append-system.md` | 3 |
| 7 | Create an `agents.md` file for a real project | 3 |
| 14 | Explain why adding too many agents.md files is harmful | 3 |
| 30 | Design a context initialization for your own agent | 3 |
| 1 | Name the 2 moments checkCompaction is called | 4 |
| 3 | Describe Pi's token-counting method vs character-counting | 4 |
| 7 | List the 6 sections of a compaction summary | 4 |
| 14 | Explain why compaction happens at turn end AND before prompt | 4 |
| 30 | Design a checkCompaction function for your own agent | 4 |
| 1 | Draw the tool call loop with 2 iterations | 5 |
| 3 | Name 3 LLM providers Pi supports | 5 |
| 7 | Trace a "refactor file" request through all tool call steps | 5 |
| 14 | Explain why tool results must go back into the LLM | 5 |
| 30 | Design the tool execution loop for your own agent | 5 |
| 1 | Locate your Pi session files on disk | 6 |
| 3 | Explain why JSONL is better than JSON array for sessions | 6 |
| 7 | Open a session file and identify each message type | 6 |
| 14 | Describe the 5 fields in each message object | 6 |
| 30 | Design a session storage format for your own agent using JSONL | 6 |
| 1 | Draw a session tree with 2 branches from memory | 7 |
| 3 | Explain how parentId enables tree structure in a flat file | 7 |
| 7 | Use /tree in a real session and identify branches | 7 |
| 14 | Compare Pi's tree approach to a simple message list | 7 |
| 30 | Design parentId-based tree structure for your own agent | 7 |
| 1 | List Pi's 4 default tools from memory | 8 |
| 3 | Explain the difference between edit and write | 8 |
| 7 | Design a 3-tool workflow for a coding task | 8 |
| 14 | Explain why a minimal toolset is actually powerful | 8 |
| 30 | Compare Pi's tool design to an agent with 20+ tools | 8 |
| 1 | List 5 things an extension can do in Pi | 9 |
| 3 | Explain event subscription in Pi's architecture | 9 |
| 7 | Design an extension concept for a task you automate regularly | 9 |
| 14 | Explain why Pi's modular design makes extensions clean | 9 |
| 30 | Build a simple TypeScript extension that subscribes to agent_response | 9 |
| 1 | Describe Pi's 4 system prompt sections from memory | 10 |
| 3 | Create your own append-system.md with useful preferences | 10 |
| 7 | Explain why skills use markup tags in the prompt | 10 |
| 14 | Write a complete custom system.md for a specialized agent | 10 |
| 30 | Design system prompt strategy for a new agent you're building | 10 |
| 1 | List the steps main.ts performs in order | 11 |
| 3 | Explain the difference between RPC and STDIO mode | 11 |
| 7 | Write a shell script using Pi in STDIO mode for automation | 11 |
| 14 | Map out a custom CLI entry point for your own agent | 11 |
| 30 | Design a complete entry point architecture for your agent | 11 |
| 1 | Name the 3 main regions of Pi's TUI | 12 |
| 3 | Explain what "component-based" means for TUI rendering | 12 |
| 7 | Describe how components subscribe to agent loop events | 12 |
| 14 | Compare Pi's TUI approach to a Textual-based TUI | 12 |
| 30 | Sketch a component architecture for a TUI you would build | 12 |
| 1 | Describe the 7-step skill invocation flow | 13 |
| 3 | Explain why lazy-loading skill content keeps context lean | 13 |
| 7 | Compare skills to custom commands — list 3 differences | 13 |
| 14 | Design a skill system for your own agent | 13 |
| 30 | Implement the TUI intercept logic for skill invocation in pseudocode | 13 |

