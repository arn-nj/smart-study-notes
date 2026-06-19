<?xml version="1.0" encoding="utf-8"?>
<map version="1.0.1">
  <node TEXT="Pi Architecture — Agent Loop, Tools, TUI and More">
    <node TEXT="1. Introduction — What is Pi?">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi is a minimalist AI coding agent built entirely from scratch" />
        <node TEXT="Two main parts: **PyCore** (the engine) and **PyInteractive** (the interface)" />
      </node>
      <node TEXT="Demo Walkthrough">
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Pi: A minimalist AI coding agent, entirely custom-built, no external frameworks" />
        <node TEXT="PyCore: The agentic loop — handles conversations, tools, sessions" />
        <node TEXT="PyInteractive: The interface layer — TUI, CLI entry, skills, extensions" />
        <node TEXT="RPC Mode: Pi can also be called programmatically, not just interactively" />
      </node>
    </node>
    <node TEXT="2. The Agentic Loop — Core Engine Overview">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Every message you send triggers a fixed 3-phase loop: Initialize → Transform → LLM Call" />
        <node TEXT="This loop is the same whether it's your first message or your hundredth" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: **Initialize Context** — assemble system prompt + skills + tools + history + your message" />
        <node TEXT="Step 2: **Transform Context** — check if compaction is needed; compact if so" />
        <node TEXT="Step 3: **LLM Call** — send full context to selected model" />
        <node TEXT="Step 4: **Tool Loop** — model calls tools (read/edit/bash/write); results fed back; repeat until done" />
        <node TEXT="Step 5: **Final Reply** — model decides no more tool calls needed; emits response to you" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Agent Loop: The repeating cycle that processes every user message" />
        <node TEXT="Context Window: The combined token budget holding system prompt + history + tools" />
        <node TEXT="Tool Call: A structured request from the LLM to use a tool (e.g. read a file)" />
        <node TEXT="Turn: One complete pass through the loop, ending in a final reply" />
      </node>
    </node>
    <node TEXT="3. Context Initialization — Building the System Prompt">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Context is built in layers: system prompt → agents.md files → skill descriptions → tool descriptions → history → your message" />
        <node TEXT="You can customize almost every layer" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Load **system prompt** (hardcoded; override with `system.md` in `.pi/` or `--system-prompt` flag)" />
        <node TEXT="Step 2: Append **agents.md** files from home directory AND current working directory" />
        <node TEXT="Step 3: Append **skill descriptions** (name + short description, not full skill content)" />
        <node TEXT="Step 4: Append **tool descriptions** for all loaded tools" />
        <node TEXT="Step 5: Append **message history** (or compacted summary if previously compacted)" />
        <node TEXT="Step 6: Append **your current message**" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="system.md: Place in `.pi/` to override the default system prompt" />
        <node TEXT="append-system.md: Place in `.pi/` to ADD to (not replace) the default prompt" />
        <node TEXT="agents.md: Markdown file Pi auto-loads — use for persistent project context" />
        <node TEXT="Skill description: Short summary loaded into context; full skill content loaded only when invoked" />
      </node>
    </node>
    <node TEXT="4. Context Transformation — When and How Pi Compacts">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi calls `checkCompaction` at two moments: after every agent turn AND before every new prompt" />
        <node TEXT="Instead of estimating tokens upfront, Pi trusts the LLM's own usage numbers in its response" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Agent turn ends OR user is about to send a prompt → trigger `checkCompaction`" />
        <node TEXT="Step 2: Check token count: use LLM-provided usage if available (input + output + cache read + cache write)" />
        <node TEXT="Step 3: If no usage in response → estimate: add `usage.input` + `usage.output` + `cache.read` + `cache.write`" />
        <node TEXT="Step 4: If total is near the context limit → run compaction summarization" />
        <node TEXT="Step 5: Compaction = send full history to LLM with special summarization prompt → get structured summary" />
        <node TEXT="Step 6: Replace message history with this summary for all future turns" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="checkCompaction: Pi's function to decide if history needs to be compressed" />
        <node TEXT="Compaction trigger: After agent turn ends OR before next user prompt" />
        <node TEXT="Token estimation: Uses LLM response usage fields (input + output + cache)" />
        <node TEXT="Compacted summary: Structured checkpoint stored instead of raw message history" />
      </node>
    </node>
    <node TEXT="5. The LLM Call &amp; Tool Execution Loop">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi sends the full assembled context to the LLM → model either makes a tool call OR gives a final reply" />
        <node TEXT="Tool results flow back into the LLM; this repeats until no more tool calls" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Full context (with assembled prompt + history) sent to configured LLM provider" />
        <node TEXT="Step 2: LLM returns either: **(a) tool call** or **(b) final text reply**" />
        <node TEXT="Step 3: If tool call: Pi executes the tool, captures output, appends to context" />
        <node TEXT="Step 4: LLM is called again with the updated context including tool result" />
        <node TEXT="Step 5: Steps 3-4 repeat until LLM returns a final text reply" />
        <node TEXT="Step 6: Final reply is shown to the user; turn ends" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Tool call: Structured JSON returned by LLM specifying which tool to invoke and with what args" />
        <node TEXT="Tool result: The output of executing that tool, appended back to context" />
        <node TEXT="Provider: Which LLM serves the call — can be OpenAI, Anthropic, Kimi, Minimax, etc." />
        <node TEXT="Turn: Entire tool loop from first LLM call to final reply" />
      </node>
    </node>
    <node TEXT="6. Sessions &amp; Memory — JSONL Storage">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Sessions are stored as JSONL files (one JSON object per line) organized by working directory" />
        <node TEXT="JSONL allows appending new messages without rewriting the entire file" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Pi maps sessions to working directories (path encoded as directory name)" />
        <node TEXT="Step 2: Each session = one `.jsonl` file with a unique ID" />
        <node TEXT="Step 3: Every message (user, assistant, tool call, tool result) is appended as a new JSON line" />
        <node TEXT="Step 4: Each line contains: `id`, `parentId`, `type`, `role`, `content`, `timestamp`" />
        <node TEXT="Step 5: Compacted summaries replace raw history lines when compaction occurs" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="JSONL: JSON Lines — one JSON object per line; easy to append without parsing the whole file" />
        <node TEXT="Session file: `.jsonl` file in `~/.pi/agent/sessions/&lt;directory&gt;/`" />
        <node TEXT="Working directory mapping: Sessions are organized by the directory Pi was run in" />
        <node TEXT="Append-only: New messages are always appended to end — never overwrites old lines" />
      </node>
    </node>
    <node TEXT="7. Session Tree Structure — Forking Conversations">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Every message has a `parentId` pointing to the message it branched from — this creates a tree automatically" />
        <node TEXT="You can fork at any point (`/tree` to navigate, select a past node, start fresh from there)" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Every message written to JSONL has an `id` field (unique) and a `parentId` (previous message's id)" />
        <node TEXT="Step 2: Messages with the SAME `parentId` = forked branches from the same parent" />
        <node TEXT="Step 3: Pi reads the tree by following `parentId` chains" />
        <node TEXT="Step 4: `/tree` command in TUI shows all branches visually" />
        <node TEXT="Step 5: You can select any node to jump back and fork a new branch from that point" />
        <node TEXT="Step 6: All branches live in the same `.jsonl` file — nothing is deleted" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="parentId: Reference to the previous message — creates the tree structure" />
        <node TEXT="Fork: Start a new branch from any past message; both branches coexist in the file" />
        <node TEXT="/tree: TUI command to visualize and navigate all conversation branches" />
        <node TEXT="Branch: A path through the conversation tree; multiple can stem from one parent" />
      </node>
    </node>
    <node TEXT="8. Core Tools — The Minimal Toolbox">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi ships with 4 tools: **read**, **bash**, **edit**, **write**" />
        <node TEXT="Grep and find also exist but are disabled by default (read-only mode only)" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: LLM decides which tool to call and with what arguments" />
        <node TEXT="Step 2: Pi executes the tool (file I/O, shell command, etc.)" />
        <node TEXT="Step 3: Result is returned to the LLM as a tool response" />
        <node TEXT="Step 4: For read-only mode: run Pi with `--tools read,grep,find` to restrict to safe tools" />
        <node TEXT="Step 5: Add extra tools: ask Pi to create a new tool, or install packages" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="read: Read any file from the filesystem" />
        <node TEXT="bash: Execute arbitrary shell commands" />
        <node TEXT="edit: Apply targeted changes to an existing file" />
        <node TEXT="write: Create or overwrite a file" />
        <node TEXT="Read-only mode: `--tools read,grep,find` — useful for programmatic/RPC use" />
      </node>
    </node>
    <node TEXT="9. Extensions — Extending Pi's Capabilities">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Extensions are TypeScript packages that plug into Pi's event system" />
        <node TEXT="They can add tools, commands, keyboard shortcuts, system prompt content, and custom message rendering" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Write extension as TypeScript package" />
        <node TEXT="Step 2: Package defines which events to subscribe to and what to do" />
        <node TEXT="Step 3: When Pi starts, it loads all installed extensions" />
        <node TEXT="Step 4: Extension hooks fire at the appropriate points in the agent loop" />
        <node TEXT="Step 5: New tools registered by extensions appear in Pi's tool list" />
        <node TEXT="Step 6: Custom commands/shortcuts available immediately in TUI" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Extension: A TypeScript package that plugs into Pi's event system" />
        <node TEXT="Event subscription: Register to fire code when specific loop events occur" />
        <node TEXT="Tool registration: Add entirely new tools (e.g. web search, browser, API calls)" />
        <node TEXT="Modular design: Pi's architecture explicitly supports this — no hacks needed" />
      </node>
    </node>
    <node TEXT="10. System Prompt Deep Dive — What Pi Tells Itself">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi's system prompt is ~20 lines — extremely minimal" />
        <node TEXT="It tells the agent what it is, lists skills with markup tags, and includes current date + working directory" />
      </node>
      <node TEXT="Demo Walkthrough">
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="System prompt: The root instruction set passed to the LLM at every turn" />
        <node TEXT="Skills markup: Skills are embedded with XML-like tags in the prompt — this allows TUI to parse them" />
        <node TEXT="append-system.md: Adds your content after Pi's default prompt without replacing it" />
        <node TEXT="system.md: Completely replaces Pi's default prompt — use with caution" />
      </node>
    </node>
    <node TEXT="11. CLI Entry Point — From Command to Agent Session">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Two files handle startup: `client.ts` (receives the command) and `main.ts` (orchestrates everything)" />
        <node TEXT="It's not until `main.ts` that the actual agent session is created" />
      </node>
      <node TEXT="Demo Walkthrough">
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="client.ts: Entry point; receives command, delegates to main" />
        <node TEXT="main.ts: Parses args, loads config, loads extensions, creates session, runs mode" />
        <node TEXT="Interactive mode: Full TUI experience" />
        <node TEXT="RPC mode: Programmatic API calls to Pi" />
        <node TEXT="STDIO mode: Pass a prompt via CLI arg; Pi runs once and exits" />
      </node>
    </node>
    <node TEXT="12. Terminal User Interface — The TUI Design">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Pi's TUI is completely custom — no Textual, no React Terminal, no third-party UI lib" />
        <node TEXT="It's component-based: each component manages its own rendering, input handling, and dynamic updates" />
      </node>
      <node TEXT="Demo Walkthrough">
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Custom TUI: Built entirely in TypeScript for Pi — no external TUI libraries" />
        <node TEXT="Component-based: Each component = own render logic + input handling + dynamic updates" />
        <node TEXT="Event subscription: Components subscribe to agent loop events to update dynamically" />
        <node TEXT="No flicker: Each component redraws independently — no full screen clear/redraw" />
      </node>
    </node>
    <node TEXT="13. Skills System — How Pi Reads and Uses Skills">
      <node TEXT="How It Works (Easy Breakdown)">
        <node TEXT="Skills are `.md` files with detailed instructions; only their **description** goes into the system prompt" />
        <node TEXT="When a skill is invoked, the TUI intercepts the command and sends the skill's **location** — Pi reads it on demand" />
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Step 1: Skill descriptions (short) are listed in system prompt at startup" />
        <node TEXT="Step 2: User types `/skill:&lt;name&gt;` in TUI" />
        <node TEXT="Step 3: TUI intercepts the command (never reaches PyCore raw)" />
        <node TEXT="Step 4: TUI transforms it into a structured message with: name, description, and **file location**" />
        <node TEXT="Step 5: This transformed message is sent to the LLM" />
        <node TEXT="Step 6: LLM calls `read` tool on the provided location to get full skill content" />
        <node TEXT="Step 7: LLM then executes the skill's instructions" />
        <node TEXT="Step 8: Custom `/commands` (not skills): TUI replaces them with full prompt text directly — never reach PyCore" />
      </node>
      <node TEXT="Key Concepts You Can Explain">
        <node TEXT="Skill: A `.md` file with detailed instructions — only description in system prompt" />
        <node TEXT="Skill invocation: `/skill:&lt;name&gt;` — intercepted by TUI, not passed raw to PyCore" />
        <node TEXT="Lazy loading: Full skill content loaded by LLM on demand via read tool" />
        <node TEXT="Custom commands: Slash commands that are simple prompt replacements — fully expanded at TUI layer" />
      </node>
    </node>
  </node>
</map>