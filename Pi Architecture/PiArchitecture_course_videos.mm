<map version="1.0.1">
  <node TEXT="Pi Architecture — Agent Loop, Tools, TUI and More">
    <node TEXT="1. Introduction — What is Pi?">
      <node TEXT="What You'll Learn">
        <node TEXT="Pi is a minimalist AI coding agent built from scratch"/>
        <node TEXT="Two parts: PyCore (engine) and PyInteractive (interface)"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="PyCore: agentic loop + sessions + tools"/>
        <node TEXT="PyInteractive: TUI + CLI + skills + extensions"/>
        <node TEXT="RPC Mode: call Pi programmatically"/>
        <node TEXT="No external agent frameworks used"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: Design philosophy? A: Minimalist, custom-built"/>
        <node TEXT="Q: What is PyCore? A: Agentic loop engine"/>
        <node TEXT="Q: What is PyInteractive? A: TUI + CLI + skills + extensions"/>
      </node>
    </node>
    <node TEXT="2. The Agentic Loop — Core Engine">
      <node TEXT="What You'll Learn">
        <node TEXT="3-phase loop: Init Context, Transform Context, LLM Call"/>
        <node TEXT="Same loop runs for every message"/>
      </node>
      <node TEXT="3 Phases">
        <node TEXT="Phase 1: Initialize Context"/>
        <node TEXT="Phase 2: Transform Context (compaction check)"/>
        <node TEXT="Phase 3: LLM Call + Tool Execution Loop"/>
      </node>
      <node TEXT="Key Concepts">
        <node TEXT="Agent Loop: repeating cycle per user message"/>
        <node TEXT="Context Window: token budget for all context"/>
        <node TEXT="Tool Call: LLM request to use a tool"/>
        <node TEXT="Turn: one pass from message to final reply"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: 3 phases? A: Init, Transform, LLM Call"/>
        <node TEXT="Q: Multiple tool calls? A: Yes — hundreds possible"/>
        <node TEXT="Q: Loop ends when? A: LLM emits final reply"/>
      </node>
    </node>
    <node TEXT="3. Context Initialization">
      <node TEXT="What You'll Learn">
        <node TEXT="6 layers assembled before every LLM call"/>
        <node TEXT="How to extend and override the context"/>
      </node>
      <node TEXT="6 Layers (in order)">
        <node TEXT="1. System prompt (hardcoded)"/>
        <node TEXT="2. agents.md files (home + cwd)"/>
        <node TEXT="3. Skill descriptions (short blurbs only)"/>
        <node TEXT="4. Tool descriptions (all loaded tools)"/>
        <node TEXT="5. Message history (or compacted summary)"/>
        <node TEXT="6. Current user message"/>
      </node>
      <node TEXT="Customization">
        <node TEXT="system.md — override entire system prompt"/>
        <node TEXT="append-system.md — add to prompt without replacing"/>
        <node TEXT="agents.md — project context auto-loaded"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: 6 context layers? A: prompt, agents.md, skill descs, tools, history, message"/>
        <node TEXT="Q: append-system.md? A: Adds to prompt, doesn't replace"/>
        <node TEXT="Q: What goes in for skills? A: Only description, not full content"/>
      </node>
    </node>
    <node TEXT="4. Context Transformation &amp;amp; Compaction">
      <node TEXT="What You'll Learn">
        <node TEXT="checkCompaction called after turn + before prompt"/>
        <node TEXT="Uses LLM response usage fields for token counting"/>
      </node>
      <node TEXT="Compaction Trigger Points">
        <node TEXT="After agent turn ends"/>
        <node TEXT="Before each user prompt is sent"/>
      </node>
      <node TEXT="Token Counting Method">
        <node TEXT="Uses LLM usage response fields if available"/>
        <node TEXT="Adds: input + output + cache.read + cache.write"/>
      </node>
      <node TEXT="Compaction Summary Sections">
        <node TEXT="Goal"/>
        <node TEXT="Constraints and preferences"/>
        <node TEXT="Progress (done / in-progress / blocked)"/>
        <node TEXT="Key decisions"/>
        <node TEXT="Next steps"/>
        <node TEXT="Critical context"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: When called? A: After turn ends + before prompt"/>
        <node TEXT="Q: Token count? A: From LLM usage response fields"/>
        <node TEXT="Q: Summary has? A: Goal, constraints, progress, decisions, next steps, context"/>
      </node>
    </node>
    <node TEXT="5. LLM Call &amp;amp; Tool Execution Loop">
      <node TEXT="What You'll Learn">
        <node TEXT="Full context sent to LLM provider"/>
        <node TEXT="Tool results fed back into LLM repeatedly"/>
      </node>
      <node TEXT="Tool Loop Steps">
        <node TEXT="1. Send full context to LLM provider"/>
        <node TEXT="2. LLM returns tool call OR final reply"/>
        <node TEXT="3. Execute tool, capture output"/>
        <node TEXT="4. Append result to context"/>
        <node TEXT="5. Call LLM again"/>
        <node TEXT="6. Repeat until final reply"/>
      </node>
      <node TEXT="Supported Providers">
        <node TEXT="OpenAI"/>
        <node TEXT="Anthropic"/>
        <node TEXT="Kimi"/>
        <node TEXT="Minimax"/>
        <node TEXT="Others"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: LLM can return? A: Tool call or final reply"/>
        <node TEXT="Q: After tool? A: Result appended, LLM called again"/>
        <node TEXT="Q: Turn ends when? A: LLM replies without tool call"/>
      </node>
    </node>
    <node TEXT="6. Sessions &amp;amp; Memory — JSONL Storage">
      <node TEXT="What You'll Learn">
        <node TEXT="Sessions stored as JSONL files on disk"/>
        <node TEXT="Organized by working directory"/>
      </node>
      <node TEXT="Storage Location">
        <node TEXT="~/.pi/agent/sessions/"/>
        <node TEXT="Subdirectory per working directory"/>
        <node TEXT="Each session = one .jsonl file"/>
      </node>
      <node TEXT="JSONL Message Fields">
        <node TEXT="id — unique message identifier"/>
        <node TEXT="parentId — reference to parent message"/>
        <node TEXT="type — message / tool_call / tool_result"/>
        <node TEXT="role — user / assistant"/>
        <node TEXT="content — message text"/>
        <node TEXT="timestamp"/>
      </node>
      <node TEXT="Why JSONL?">
        <node TEXT="Append-only: new line per message"/>
        <node TEXT="No file rewrite needed"/>
        <node TEXT="Readable in any text editor"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: Where stored? A: ~/.pi/agent/sessions/"/>
        <node TEXT="Q: Format? A: JSONL — one JSON object per line"/>
        <node TEXT="Q: JSONL advantage? A: Append without rewriting full file"/>
      </node>
    </node>
    <node TEXT="7. Session Tree Structure — Forking">
      <node TEXT="What You'll Learn">
        <node TEXT="parentId creates tree structure in flat JSONL file"/>
        <node TEXT="/tree command navigates branches"/>
      </node>
      <node TEXT="How Forking Works">
        <node TEXT="Two messages with same parentId = two branches"/>
        <node TEXT="Both branches in same .jsonl file"/>
        <node TEXT="Original never deleted"/>
      </node>
      <node TEXT="Tree Navigation">
        <node TEXT="/tree command in TUI"/>
        <node TEXT="Shows all branches visually"/>
        <node TEXT="Select any node to jump back and fork"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: What creates tree? A: parentId field in each message"/>
        <node TEXT="Q: Navigate tree? A: /tree command"/>
        <node TEXT="Q: Multiple forks? A: Yes, unlimited, all in same file"/>
      </node>
    </node>
    <node TEXT="8. Core Tools — The Minimal Toolbox">
      <node TEXT="What You'll Learn">
        <node TEXT="Pi ships with exactly 4 default tools"/>
        <node TEXT="Grep and find disabled by default"/>
      </node>
      <node TEXT="Default Tools">
        <node TEXT="read — read file contents"/>
        <node TEXT="bash — run shell commands"/>
        <node TEXT="edit — make targeted file edits"/>
        <node TEXT="write — create or overwrite files"/>
      </node>
      <node TEXT="Additional Tools">
        <node TEXT="grep — disabled, for read-only mode"/>
        <node TEXT="find — disabled, for read-only mode"/>
        <node TEXT="Enable with --tools read,grep,find"/>
      </node>
      <node TEXT="Extending Tools">
        <node TEXT="Web search — recommended first addition"/>
        <node TEXT="Install as extensions"/>
        <node TEXT="Ask Pi to create new tools"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: 4 default tools? A: read, bash, edit, write"/>
        <node TEXT="Q: Grep/find why disabled? A: For read-only mode only"/>
        <node TEXT="Q: First extension to add? A: Web search"/>
      </node>
    </node>
    <node TEXT="9. Extensions — Extending Pi">
      <node TEXT="What You'll Learn">
        <node TEXT="Extensions are TypeScript packages"/>
        <node TEXT="Plug into Pi's event emitter system"/>
      </node>
      <node TEXT="What Extensions Can Do">
        <node TEXT="Register new tools"/>
        <node TEXT="Subscribe to agent loop events"/>
        <node TEXT="Register slash commands"/>
        <node TEXT="Add keyboard shortcuts"/>
        <node TEXT="Add CLI flags"/>
        <node TEXT="Update system prompt"/>
        <node TEXT="Render custom messages"/>
      </node>
      <node TEXT="Agent Loop Events">
        <node TEXT="tool_call"/>
        <node TEXT="agent_response"/>
        <node TEXT="user_message"/>
        <node TEXT="Every loop step emits events"/>
      </node>
      <node TEXT="Security Note">
        <node TEXT="Extensions execute code on your system"/>
        <node TEXT="Only install from trusted sources"/>
        <node TEXT="Have Pi review extension code first"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: Extension language? A: TypeScript"/>
        <node TEXT="Q: 5 things extensions do? A: tools, events, commands, shortcuts, prompt"/>
        <node TEXT="Q: Security concern? A: They run on your system"/>
      </node>
    </node>
    <node TEXT="10. System Prompt Deep Dive">
      <node TEXT="What You'll Learn">
        <node TEXT="~20 lines — extremely minimal"/>
        <node TEXT="4 sections: identity + skills markup + date + cwd"/>
      </node>
      <node TEXT="Prompt Sections">
        <node TEXT="Identity: you are Pi, helpful assistant"/>
        <node TEXT="Skills: XML markup with name + description"/>
        <node TEXT="Current date"/>
        <node TEXT="Current working directory"/>
      </node>
      <node TEXT="Customization Options">
        <node TEXT="system.md — replace entire prompt"/>
        <node TEXT="append-system.md — add to end (recommended)"/>
        <node TEXT="--system-prompt flag — replace via CLI"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: Prompt length? A: ~20 lines"/>
        <node TEXT="Q: Skills in prompt? A: XML markup, name + description only"/>
        <node TEXT="Q: system.md vs append-system.md? A: replace vs add"/>
      </node>
    </node>
    <node TEXT="11. CLI Entry Point">
      <node TEXT="What You'll Learn">
        <node TEXT="Two files: client.ts and main.ts"/>
        <node TEXT="3 run modes: interactive, RPC, STDIO"/>
      </node>
      <node TEXT="client.ts">
        <node TEXT="Receives pi command"/>
        <node TEXT="Sets process title"/>
        <node TEXT="Calls main()"/>
      </node>
      <node TEXT="main.ts">
        <node TEXT="Parses arguments"/>
        <node TEXT="Resolves configuration"/>
        <node TEXT="Loads extensions"/>
        <node TEXT="Creates agent session (PyCore)"/>
        <node TEXT="Runs in selected mode"/>
      </node>
      <node TEXT="Run Modes">
        <node TEXT="Interactive — full TUI experience"/>
        <node TEXT="RPC — programmatic API calls"/>
        <node TEXT="STDIO — single prompt, exits after"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: What calls main()? A: client.ts"/>
        <node TEXT="Q: When is PyCore created? A: In main.ts after config + extensions loaded"/>
        <node TEXT="Q: 3 run modes? A: Interactive, RPC, STDIO"/>
      </node>
    </node>
    <node TEXT="12. Terminal User Interface (TUI)">
      <node TEXT="What You'll Learn">
        <node TEXT="100% custom TUI — no external framework"/>
        <node TEXT="Component-based architecture"/>
      </node>
      <node TEXT="TUI Layout">
        <node TEXT="Message Area (scrollable)"/>
        <node TEXT="Input Bar"/>
        <node TEXT="Status Bar (model / tokens / directory)"/>
      </node>
      <node TEXT="Design Principles">
        <node TEXT="No external TUI library"/>
        <node TEXT="Component-based: each owns render + input + updates"/>
        <node TEXT="Subscribe to agent loop events"/>
        <node TEXT="No flicker — independent component redraws"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: External framework? A: None — 100% custom TypeScript"/>
        <node TEXT="Q: Component model? A: Each component owns render, input, update"/>
        <node TEXT="Q: How components update? A: Subscribe to agent loop events"/>
      </node>
    </node>
    <node TEXT="13. Skills Management System">
      <node TEXT="What You'll Learn">
        <node TEXT="Skill descriptions in prompt — full content lazy-loaded"/>
        <node TEXT="TUI intercepts /skill: command"/>
      </node>
      <node TEXT="Skill Invocation Flow">
        <node TEXT="1. Skill descriptions in system prompt at startup"/>
        <node TEXT="2. User types /skill:name"/>
        <node TEXT="3. TUI intercepts command"/>
        <node TEXT="4. TUI adds name + description + file location to message"/>
        <node TEXT="5. LLM receives structured message"/>
        <node TEXT="6. LLM calls read tool on file location"/>
        <node TEXT="7. LLM reads full SKILL.md content"/>
        <node TEXT="8. LLM executes skill instructions"/>
      </node>
      <node TEXT="Custom Commands vs Skills">
        <node TEXT="Custom commands: fully expanded at TUI layer"/>
        <node TEXT="Skills: lazy-loaded by LLM via read tool"/>
      </node>
      <node TEXT="Flashcards">
        <node TEXT="Q: Skills in system prompt? A: Description only, not content"/>
        <node TEXT="Q: How full content loaded? A: LLM reads file via read tool"/>
        <node TEXT="Q: Commands vs skills? A: Commands expanded immediately; skills lazy-loaded"/>
      </node>
    </node>
  </node>
</map>
