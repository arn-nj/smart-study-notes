<map version="1.0.1">
<node TEXT="Hermes Architecture — Memory, Context &amp; Gateways" FOLDED="false">

  <node TEXT="Bird&apos;s Eye View — Hermes Agent Architecture" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Three entry points (CLI, Gateway, API) converge on one AI Agent Core — no separate logic per transport channel"/>
      <node TEXT="CLI is synchronous and user-initiated; Gateway is always-on and event-driven; API is programmatic — all produce identical agent behaviour"/>
      <node TEXT="Bundled services ship out-of-the-box: Tools (web search, file ops), Skills (automation workflows), Memory (two tiers — zero extra config required)"/>
      <node TEXT="Internal memory is purely local: markdown files (soul.md, user.md, memory.md) plus SQLite session transcripts — works offline with no provider setup"/>
      <node TEXT="External memory (Mem0, SuperMemory, Honcho) is an optional upgrade layer for long-term cross-session recall — not active by default"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: developer installs Hermes and runs it immediately from the CLI with no additional configuration"/>
      <node TEXT="CLI connects directly to AI Agent Core; soul.md is empty so the default Hermes system identity is loaded"/>
      <node TEXT="First response comes from the generic assistant identity; user.md is empty so no personalisation yet"/>
      <node TEXT="After the conversation ends, the memory update step writes any identified user facts into user.md automatically"/>
      <node TEXT="Result: immediate usability with zero configuration, personalisation growing passively with each session"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Observe identical agent behaviour regardless of entry point"/>
      <node TEXT="Setup: Install Hermes; optionally configure a Telegram gateway alongside the CLI"/>
      <node TEXT="Steps: Run &apos;hermes&apos; in terminal → send a question → note response style; send the same question via Telegram bot → compare"/>
      <node TEXT="Expected Result: Both channels produce the same agent personality, tone, and reasoning — confirming the transport layer is decoupled from agent logic"/>
      <node TEXT="Why this works: All routes converge on the AI Agent Core before reaching the LLM; routing decisions happen at the transport layer and do not affect context assembly"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: Team wants one Hermes instance shared across a CLI power user, a Slack bot, and a REST API integration"/>
      <node TEXT="Constraint: Each user must have isolated conversation history — they cannot see each other&apos;s messages"/>
      <node TEXT="Decision: Use per-user composite session IDs (platform + session + user ID) in SQLite to create isolated history buckets per user per channel"/>
      <node TEXT="Concept: Session ID namespacing at the SQLite level provides logical isolation without requiring separate agent instances"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="CLI vs Gateway: CLI requires user presence; Gateway enables async access across platforms — trade-off is setup complexity per platform"/>
      <node TEXT="Internal vs External memory: Internal is zero-config but capped by context window; External adds persistent recall across long time horizons but requires provider setup and adds network latency"/>
      <node TEXT="Minimal default config: Hermes works immediately out-of-the-box but without personalisation until soul.md and user.md are populated"/>
    </node>
  </node>

  <node TEXT="The Agent Loop" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Every user message triggers a deterministic 5-step loop: Build Context → Call LLM → Execute Tools (sub-loop) → Final Response → Memory Update"/>
      <node TEXT="Tool execution is a sub-loop not a single step: LLM decides to call a tool → tool executes → result injected back → LLM decides again, repeating until no more tools are needed"/>
      <node TEXT="The memory update step fires after every single response and converts a stateless LLM call into a continuously learning agent — it writes new user info to user.md and new workflow facts to memory.md"/>
      <node TEXT="Architecture mirrors minimalist agents like PyAgent and OpenCode — simplicity is deliberate; the loop is easy to reason about, debug, and extend"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Task: &apos;Research this week&apos;s AI papers and save the titles to a file&apos;"/>
      <node TEXT="LLM calls web_search(&apos;AI papers this week&apos;) → receives list of results; result injected back into context"/>
      <node TEXT="LLM then calls write_file(&apos;ai_papers.txt&apos;, titles) → file created on disk; result confirmed back to LLM"/>
      <node TEXT="LLM produces final summary response; no more tools needed"/>
      <node TEXT="Memory update: notes user interest in AI research papers; writes entry to memory.md for future sessions"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Observe the full loop including multi-step tool use and the memory update step"/>
      <node TEXT="Setup: Hermes installed with web search tool enabled"/>
      <node TEXT="Steps: Ask &apos;What is the current Bitcoin price?&apos; → Hermes calls web_search → returns live price → responds; then open memory.md and check for new entries"/>
      <node TEXT="Expected Result: Accurate live price in the response; possible entry in memory.md if Hermes judged the interest in financial data worth remembering"/>
      <node TEXT="Why this works: Tool results are injected back into the LLM context as message history items, allowing the model to reason over real-time data before generating its answer"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: Complex debugging session with 15 back-and-forth messages, each triggering 3-4 tool calls (file reads, searches, writes)"/>
      <node TEXT="Constraint: Cannot lose context from early tool results while the session continues; context window is finite"/>
      <node TEXT="Decision: All tool results accumulate within the message history; context compression fires at 50% threshold to preserve the most important prior context in a structured summary"/>
      <node TEXT="Concept: The tool sub-loop and context compression are complementary mechanisms — one enables depth within a turn; the other preserves depth across turns"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Memory update on every turn: Ensures continuous learning but adds a small post-response latency cost (one extra LLM analysis call)"/>
      <node TEXT="Minimalist loop design: Easy to debug and reason about, but lacks built-in parallel tool execution or branching logic"/>
      <node TEXT="Broad tool availability: More tools increase capability but each tool description consumes context tokens even when the tool is not used in that turn"/>
    </node>
  </node>

  <node TEXT="Context Building" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Context is assembled in a fixed priority order: soul.md (personality baseline) → user.md → memory.md → external memory summaries → skill &amp; tool descriptions → message history"/>
      <node TEXT="soul.md is the most impactful single file — it is the effective system prompt; a well-crafted soul.md completely changes the agent&apos;s tone, domain focus, and reasoning approach"/>
      <node TEXT="user.md is auto-maintained: Hermes writes user-specific information here whenever it identifies it in conversation, without being asked — the profile accumulates passively across all sessions"/>
      <node TEXT="memory.md stores workflow-level knowledge: patterns, preferred tools, learned procedures — not tied to the user personally but to what Hermes found useful in this environment"/>
      <node TEXT="External memory summaries only appear when a provider is configured; without one, the context is lean and purely local"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="User has 3 months of Hermes usage; user.md contains: job title (DevOps engineer), preferred response format (concise bullets), primary tools (Python, Bash, Terraform)"/>
      <node TEXT="New query: &apos;Help me write a Python script to parse a JSON config file&apos;"/>
      <node TEXT="Context built: soul.md → user.md (Python, concise) → memory.md (past scripts) → tool descriptions → question"/>
      <node TEXT="LLM produces a concise, Pythonic script with Bash integration hints — no re-explanation of preferences needed"/>
      <node TEXT="Result: Personalised, context-aware response from the very first word, entirely driven by the auto-accumulated context"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Observe how soul.md content dramatically changes LLM response style"/>
      <node TEXT="Setup: Hermes installed with soul.md empty"/>
      <node TEXT="Steps: Ask &apos;What should I learn next for my career?&apos; → note the generic response; write &apos;You are a senior DevOps coach who gives concise, practical answers with real commands&apos; into soul.md; ask the same question again"/>
      <node TEXT="Expected Result: Second response is domain-specific, practical, and concise — dramatically different tone and content"/>
      <node TEXT="Why this works: soul.md is the first item inserted into the context window, establishing the entire framing before any user content is processed"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: Medical professional wants Hermes to always respond in clinical language, cite sources, and flag uncertainty"/>
      <node TEXT="Constraint: Cannot modify the underlying LLM; cannot include a new instruction in every message"/>
      <node TEXT="Decision: Write a detailed soul.md specifying clinical tone, citation requirements, uncertainty signalling, and domain scope"/>
      <node TEXT="Concept: soul.md functions as a persistent system prompt replacement — one-time authoring that persists across every session without any per-message overhead"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Markdown context vs vector embeddings: Markdown is transparent, human-editable, and zero-latency but limited by context window; vector search scales to large knowledge bases but adds query latency &amp; infrastructure"/>
      <node TEXT="Auto-updating user.md: Provides passive personalisation without effort but may capture incorrect inferences that require manual correction"/>
      <node TEXT="Always-included tool descriptions: LLM always knows its capabilities but descriptions consume tokens even when no tools are needed in a given turn"/>
    </node>
  </node>

  <node TEXT="Context Compression" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Compression triggers when token usage crosses a configurable threshold (default 50%) of the model&apos;s context window, preventing overflow before it causes an API error"/>
      <node TEXT="Two trigger moments: before each turn (proactive check) and on LLM error response (reactive safety net when proactive check underestimated usage)"/>
      <node TEXT="Two measurement methods reflect data availability asymmetry: characters ÷ 4 (cheap pre-first-message heuristic) vs LLM usage token count from API response (accurate, available after first turn)"/>
      <node TEXT="Hermes&apos; compression prompt is structurally rich — it preserves: overall goal, constraints, completed actions, active state, historical progress, blocked status, key decisions, resolved questions, relevant files, and critical context"/>
      <node TEXT="After compression, raw message history is replaced with the generated summary; context usage drops dramatically (often back to ~10%)"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="2-hour architecture session; context hits 50% after ~40 messages"/>
      <node TEXT="Before turn 41: stored LLM usage count exceeds 50% threshold → compression triggered"/>
      <node TEXT="Compression prompt sent to LLM covering all 40 messages → structured summary produced"/>
      <node TEXT="Summary captures: goal (design REST API), completed (DB schema + routes), active (writing middleware), decisions (FastAPI chosen), open questions (auth strategy)"/>
      <node TEXT="Turn 41 proceeds with summary instead of raw history; context usage drops from 50% to ~10%; session continues without interruption"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Directly observe context compression activating during a long session"/>
      <node TEXT="Setup: Configure Hermes with a small-context model (e.g., 8K tokens); set compression threshold to 30% in settings"/>
      <node TEXT="Steps: Start a detailed coding session with long messages → continue for ~15 exchanges → watch for a slightly longer response pause (compression call latency) → ask a question referencing an early message"/>
      <node TEXT="Expected Result: Early conversation content is now summarised but Hermes still answers correctly — confirming the structured summary preserved semantic continuity"/>
      <node TEXT="Why this works: The rich compression prompt is detailed enough that goals and decisions survive summarisation; the agent remains coherent across the compression boundary"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: Developer on a slow API with expensive per-token pricing wants to minimise unnecessary compression calls"/>
      <node TEXT="Constraint: Each compression call itself costs tokens and an additional API round-trip"/>
      <node TEXT="Decision: Raise threshold to 75-80%; accept slightly higher overflow risk in exchange for fewer compression calls"/>
      <node TEXT="Concept: Compression threshold is a cost-continuity trade-off — higher threshold = fewer compression calls + lower API cost but higher risk of context overflow errors on any given turn"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Char/4 heuristic vs model tokenizer: Tokenizer is accurate but expensive to run client-side; char/4 is free but can misfire by ±20% on code-heavy or non-English content"/>
      <node TEXT="Rich Hermes compression prompt vs minimal Pi prompt: Rich prompt preserves more semantic continuity but costs more tokens to generate the summary"/>
      <node TEXT="Default 50% threshold: Conservative enough to prevent most overflow but may trigger unnecessarily early for models with large context windows"/>
    </node>
  </node>

  <node TEXT="The Gateway" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="The Gateway is a persistent asyncio process running independently of the agent loop — it simultaneously listens to all configured messaging platforms without blocking agent processing"/>
      <node TEXT="Each platform integration is configured independently because each uses a different protocol: Telegram uses short-polling (~1s loop), Discord can use webhooks, email uses IMAP/SMTP polling"/>
      <node TEXT="Gateway receives only the single new message from the platform — no history; it reconstructs full conversation history from SQLite using a composite session ID (platform::session::user)"/>
      <node TEXT="Session ID namespacing prevents history collision: all platforms and users share one SQLite database but each conversation thread is isolated by its unique composite key"/>
      <node TEXT="Session manager handles concurrency: new message arriving while agent is busy → evaluate whether to interrupt, steer, or queue based on the user&apos;s command prefix"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="User sends &apos;Continue from where we left off&apos; via Telegram after a 3-day gap"/>
      <node TEXT="Gateway receives: single message + Telegram session ID"/>
      <node TEXT="Constructs lookup key: telegram::session123::user456"/>
      <node TEXT="Queries SQLite: retrieves all 47 prior messages from that session thread"/>
      <node TEXT="Builds full context: reconstructed history + soul.md + user.md + tool descriptions"/>
      <node TEXT="Agent responds with accurate continuation — no context loss despite the multi-day async gap"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Verify session continuity across disconnected Telegram sessions"/>
      <node TEXT="Setup: Create Telegram bot; run hermes setup gateway; enter bot token and user ID; designate as home platform"/>
      <node TEXT="Steps: Send &apos;My name is Alice and I prefer concise answers&apos; via Telegram → close session; the following day send &apos;What is my name and how do you usually respond to me?&apos; via Telegram"/>
      <node TEXT="Expected Result: Hermes answers &apos;Your name is Alice and I keep my answers concise&apos; — session history retrieved from SQLite and user.md update confirmed"/>
      <node TEXT="Why this works: Composite session ID uniquely identifies the Telegram conversation thread; SQLite persists every message; user.md was updated after the first session"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: Power user sends a follow-up question while Hermes is mid-execution of a long web research task"/>
      <node TEXT="Constraint: Interrupting might abandon partially completed work; queuing might be too slow for an urgent question"/>
      <node TEXT="Decision: Use /steer to redirect the in-progress task toward the new input without fully cancelling — the agent incorporates the new direction and adjusts its ongoing work"/>
      <node TEXT="Concept: Session manager&apos;s three modes (interrupt / steer / queue) provide a concurrency control spectrum matching different urgency levels"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Polling (Telegram) vs webhooks (Discord): Polling is simpler to set up but adds ~1-second latency; webhooks are real-time but require a public URL with valid TLS"/>
      <node TEXT="Per-platform configuration: Enables fine-grained control and per-platform auth but creates setup complexity; a unified adapter would be simpler but less flexible per platform protocol"/>
      <node TEXT="SQLite for Gateway history: Zero infrastructure, works fully offline, fast reads — but not suitable for distributed or multi-node Hermes deployments"/>
    </node>
  </node>

  <node TEXT="Memory Architecture" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Memory operates in three distinct tiers with different latency, capacity, configuration requirements, and query timing"/>
      <node TEXT="Tier 1 — Markdown files (soul.md, user.md, memory.md): loaded on every turn via file read with zero query latency; limited only by what fits in the context window"/>
      <node TEXT="Tier 2 — SQLite: stores complete verbatim session transcripts plus a bare-text table (raw message text only, no metadata) optimised for fast similarity search without full record deserialisation"/>
      <node TEXT="Tier 3 — External providers (Mem0, SuperMemory, Honcho): queried asynchronously after the first response of each conversation — the deferred query strategy ensures the topic is established before searching"/>
      <node TEXT="The &apos;wait-one-turn&apos; pattern for external memory mirrors human associative recall: you need a semantic signal before your memory search is useful"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Session 1 (2 months ago): user discussed AWS ECS container deployment in detail; external memory provider stored a semantic summary of that session"/>
      <node TEXT="Session 10 (today, new session): user opens with &apos;I&apos;m trying to deploy a new microservice&apos;"/>
      <node TEXT="Turn 1: external memory not queried — topic not yet established; agent responds based on Tier 1 only"/>
      <node TEXT="After Turn 1 response: external memory queried using current context as search signal → AWS ECS session summary retrieved"/>
      <node TEXT="Turn 2: context includes ECS deployment memory; Hermes references prior configuration details automatically without user re-explaining"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Observe external memory surfacing in a follow-up turn after a prior session on the same topic"/>
      <node TEXT="Setup: Configure Mem0 free tier as external memory; conduct one prior session on a specific topic (e.g., Python async patterns)"/>
      <node TEXT="Steps: Start a new session on the same topic → observe Turn 1 response (no prior memory yet) → send Turn 2 → observe if Hermes references the prior session context"/>
      <node TEXT="Expected Result: Turn 2 response references knowledge stored from the prior Mem0 session — deferred query confirmed working"/>
      <node TEXT="Why this works: The post-Turn-1 query gives the agent a semantically grounded signal to search against in external memory — topic-aware retrieval, not random recall"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: User has 500+ sessions in SQLite over 2 years; wants fast lookup of past debugging conversations by topic"/>
      <node TEXT="Constraint: Deserialising full session records for similarity search would be slow at that volume"/>
      <node TEXT="Decision: Query the bare-text SQLite table rather than the full session records — raw text loads faster &amp; enables lightweight BM25 or cosine similarity search"/>
      <node TEXT="Concept: Bare-text table is a deliberate performance optimisation — separation of raw text from metadata enables fast retrieval without full object deserialisation overhead"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Markdown vs SQLite: Markdown is zero-latency and always in context but size-limited; SQLite can hold millions of messages but requires explicit querying"/>
      <node TEXT="External memory providers: Add intelligent long-term recall but introduce network latency, API costs, and potential data privacy concerns for sensitive conversations"/>
      <node TEXT="Deferred external query (post-Turn-1): Avoids topic pollution on Turn 1 but means no external memories are available on the very first exchange of any session"/>
    </node>
  </node>

  <node TEXT="Cron Jobs" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Hermes cron is a self-managed internal loop — a function called tick() fires every 60 seconds as part of the Hermes process; no OS-level cron daemon or system scheduling permissions required"/>
      <node TEXT="Official documentation states jobs are stored in SQLite, but source code analysis confirms they are actually read from ~/.hermes/cron/jobs.json — a plain JSON file"/>
      <node TEXT="Each job entry contains a schedule expression (cron syntax), a prompt (the instruction to execute), and metadata; when tick() matches the current minute to a job&apos;s schedule it runs that prompt as a full agent loop call"/>
      <node TEXT="Execution results saved as run.md inside ~/.hermes/cron/output/&lt;job-id&gt;/ — provides a complete auditable history of every scheduled run per job"/>
      <node TEXT="Cron result delivery bypasses the send_message tool entirely — results go directly to the designated home messaging platform via the Gateway&apos;s system channel, ensuring delivery even when the agent loop is otherwise busy"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Cron job: &apos;Every weekday at 7:00am, retrieve top 5 tech headlines and format as a morning briefing&apos;"/>
      <node TEXT="At 7:00am Monday: tick() reads jobs.json; finds schedule match; runs prompt as full agent loop"/>
      <node TEXT="Agent calls web_search(&apos;top tech news today&apos;) → formats 5 headlines into a structured briefing"/>
      <node TEXT="Result saved to ~/.hermes/cron/output/&lt;job-id&gt;/run.md; notification pushed to user&apos;s Telegram home channel"/>
      <node TEXT="User wakes up to a formatted briefing in Telegram — no manual action required"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal: Create a minimal cron job and verify end-to-end execution"/>
      <node TEXT="Setup: Hermes running with Telegram configured as the home messaging platform"/>
      <node TEXT="Steps: Run &apos;hermes cron add &quot;* * * * *&quot; &quot;Say Tick! and list the current time&quot;&apos; → wait 60 seconds → check Telegram for the message → check ~/.hermes/cron/output/&lt;job-id&gt;/ for run.md"/>
      <node TEXT="Expected Result: Telegram receives &apos;Tick!&apos; with current time; run.md contains the full agent response text"/>
      <node TEXT="Why this works: tick() fires every 60 seconds, matches the wildcard schedule expression, executes the prompt as a full agent loop, saves the result, and routes output through the Gateway home channel"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario: DevOps engineer wants Hermes to check deployment status every 5 minutes and alert only on failure — not spam on every healthy check"/>
      <node TEXT="Constraint: Should produce no visible output on success; only send a Telegram notification when deployment status is FAILED"/>
      <node TEXT="Decision: Write a conditional prompt: &apos;Check deployment status at [endpoint]; if status is FAILED report it to me with details; if status is healthy say nothing&apos;"/>
      <node TEXT="Concept: Cron jobs run as full agent loop calls — the LLM can apply conditional logic and choose to remain silent, making jobs event-driven despite running on a fixed schedule"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Internal loop vs OS cron: Internal loop is portable and requires no system privileges, but is less resilient to process restarts — OS cron would survive process death"/>
      <node TEXT="JSON storage vs SQLite: JSON is human-readable and easy to hand-edit; SQLite would enable indexed querying of job history but is harder to inspect and modify without tooling"/>
      <node TEXT="Direct gateway delivery vs send_message tool: Direct delivery is always reliable regardless of agent loop state; but it bypasses any tool-level logging, filtering, or audit trail"/>
    </node>
  </node>

</node>
</map>
