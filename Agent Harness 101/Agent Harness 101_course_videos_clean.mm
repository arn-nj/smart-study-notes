<map version="1.0.1">
  <node TEXT="Agent Harness 101">
    <node TEXT="Page 1 - Why Agent Harnessing Appeared">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Early model usage depended on one-shot prompting that could not sustain multi-step software delivery."/>
        <node TEXT="Small context windows forced aggressive trade-offs between detailed reasoning and historical continuity."/>
        <node TEXT="Context engineering emerged as a response to memory scarcity rather than as a replacement for prompt quality."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: A user asks for an end-to-end website implementation in one request."/>
        <node TEXT="Inputs: broad feature request, no staged plan, and no focused context loading strategy."/>
        <node TEXT="Execution: agent returns a visually complete output that hides missing implementation depth."/>
        <node TEXT="Result: user receives a prototype-like response with weak operational reliability."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Demonstrate why prompt-only execution fails as task complexity expands."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Use a large implementation request without decomposition or retrieval boundaries."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Submit one-shot prompt, inspect output breadth, and compare against expected production criteria."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="The system appears productive but omits critical verification and edge behavior."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="The demonstration isolates memory and orchestration limitations that are hidden in short tasks."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: A team scales from single-file edits to multi-module delivery with shared dependencies."/>
        <node TEXT="Constraints: finite context budget, unclear dependency graph, and no iterative closure checks."/>
        <node TEXT="Recommended decision: move from one-shot execution to structured context plus looped control."/>
        <node TEXT="Concept-backed answer: reliability improves when memory use and task flow are deliberately staged."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: remain with prompt-only speed for quick prototypes."/>
        <node TEXT="Benefit: minimum setup and very fast first result."/>
        <node TEXT="Cost: poor completion confidence for long or interdependent tasks."/>
        <node TEXT="Decision guidance: use prompt-only mode for short exploratory work, not production closure."/>
      </node>
    </node>

    <node TEXT="Page 2 - Context Engineering Wins and Limits">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Tool calling narrows inputs by letting the agent read only targeted files and execute bounded actions."/>
        <node TEXT="MCP-style integrations expose vendor capabilities that enrich execution pathways and controls."/>
        <node TEXT="RAG introduces external knowledge access but depends on retrieval quality and evidence freshness."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: An agent updates multiple product surfaces using repository files plus external model-release data."/>
        <node TEXT="Inputs: file search tools, integration endpoints, retrieval index, and update instructions."/>
        <node TEXT="Execution: agent pulls selective context, performs edits, and composes updates across layers."/>
        <node TEXT="Result: precision improves, but long chains can still miss integrated verification."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Show how context engineering raises quality without fully solving long-horizon reliability."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Prepare tool interfaces, retrieval sources, and a multi-file update request."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Run targeted retrieval, execute focused actions, and inspect cross-module side effects."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="Outputs become more grounded yet still vulnerable to drift in prolonged execution."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="The walkthrough proves context quality can improve while lifecycle control remains a separate challenge."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: Enterprise repo with frequent dependency updates and shared API contracts."/>
        <node TEXT="Constraints: retrieval latency, stale embeddings, and partial integration test coverage."/>
        <node TEXT="Recommended decision: combine context engineering with explicit iteration governance."/>
        <node TEXT="Concept-backed answer: selective data access must be paired with loop-level verification."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: maximize retrieval breadth to reduce omission risk."/>
        <node TEXT="Benefit: broader evidence base for decisions."/>
        <node TEXT="Cost: larger context payloads and slower cycles."/>
        <node TEXT="Decision guidance: tune retrieval scope per task phase rather than keeping it permanently broad."/>
      </node>
    </node>

    <node TEXT="Page 3 - The Summarization Trap in Long Tasks">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Context summarization compresses history when token budgets become constrained during extended runs."/>
        <node TEXT="Lossy compression can remove acceptance criteria, unfinished subtasks, and edge-case evidence."/>
        <node TEXT="Agents may continue with false completion assumptions that accumulate hidden quality debt."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: A twelve-hour autonomous build process repeatedly compacts context to stay within limits."/>
        <node TEXT="Inputs: evolving task log, partial test output, and compressed historical summaries."/>
        <node TEXT="Execution: later iterations trust shortened summaries instead of full implementation history."/>
        <node TEXT="Result: visible features exist, but critical controls and validations remain incomplete."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Expose how memory compression can silently convert incomplete work into perceived completion."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Use a long task with many subtasks and force periodic summarization checkpoints."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Compare original task list against post-summary state and detect dropped verification items."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="At least one unverified subtask is incorrectly treated as finished after compression."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="The method highlights how memory reduction changes decision quality over time."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: Multi-environment deployment flow where test evidence must persist across many cycles."/>
        <node TEXT="Constraints: strict token budgets, noisy logs, and delayed failure discovery."/>
        <node TEXT="Recommended decision: enforce explicit completion proofs outside volatile context memory."/>
        <node TEXT="Concept-backed answer: externalized verification checkpoints prevent summary-induced false positives."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: summarize aggressively to preserve runtime continuity."/>
        <node TEXT="Benefit: longer autonomous execution before interruption."/>
        <node TEXT="Cost: increased risk of losing critical decision context."/>
        <node TEXT="Decision guidance: prefer shorter loops with persistent artifacts over oversized continuous runs."/>
      </node>
    </node>

    <node TEXT="Page 4 - Harness Engineering Controlled Iteration Loop">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Harness engineering introduces a control framework that governs task start, execution, validation, and closure."/>
        <node TEXT="The loop model resets prompt and context each iteration while preserving progress in durable artifacts."/>
        <node TEXT="Task decomposition converts broad goals into testable units that can be finished with high confidence."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: A cloud agent updates a product area while the developer is offline."/>
        <node TEXT="Inputs: requirements document, atomic task queue, and pass-fail test gates."/>
        <node TEXT="Execution: each iteration implements one item, validates behavior, and records evidence before moving on."/>
        <node TEXT="Result: completion quality improves and progress remains auditable across long durations."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Show repeatable delivery by separating planning artifacts from per-iteration execution state."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Create a requirements file, generate a task queue, and define verification checkpoints."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Select one task, execute it, run tests, document outcome, and iterate until queue completion."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="The system finishes all queued tasks with explicit evidence rather than inferred completion."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="Bounded loops reduce cognitive drift and make failures easier to isolate and recover."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: Organization runs multiple concurrent agents across features with shared release timelines."/>
        <node TEXT="Constraints: parallel updates, merge conflicts, and strict quality gates."/>
        <node TEXT="Recommended decision: assign each agent an isolated task stream under common harness standards."/>
        <node TEXT="Concept-backed answer: standardized loops keep distributed execution coherent and measurable."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: invest in harness setup before scaling autonomous workloads."/>
        <node TEXT="Benefit: stronger delivery reliability and clear accountability trails."/>
        <node TEXT="Cost: upfront design time and additional process discipline."/>
        <node TEXT="Decision guidance: adopt harnessing early when tasks exceed simple edits or single-iteration output."/>
      </node>
    </node>

    <node TEXT="Page 5 - Layer Model Prompt Context Harness">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Prompt engineering remains essential for agent identity, role framing, and behavioral constraints."/>
        <node TEXT="Context engineering supplies the right evidence and tools at each execution step."/>
        <node TEXT="Harness engineering coordinates sequencing, checks, and finish conditions across iterations."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: Two teams use similar models but different orchestration quality for the same feature scope."/>
        <node TEXT="Inputs: equivalent prompts and tool stacks with different loop governance models."/>
        <node TEXT="Execution: one team runs unbounded sessions, the other enforces bounded loop closure."/>
        <node TEXT="Result: the harnessed team ships fewer regressions and clearer completion evidence."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Clarify that harnessing builds on prompt and context layers instead of replacing either one."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Define responsibilities for all three layers before running autonomous execution."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Evaluate outputs by mapping issues back to prompt, context, or harness ownership."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="Layer clarity accelerates debugging and process refinement."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="Structured ownership prevents hidden gaps where no layer enforces quality expectations."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: Platform team standardizes autonomous development across many product squads."/>
        <node TEXT="Constraints: varied coding styles, inconsistent prompts, and fragmented retrieval practices."/>
        <node TEXT="Recommended decision: publish a shared layer contract with mandatory harness checkpoints."/>
        <node TEXT="Concept-backed answer: common layer interfaces make scaling and compliance manageable."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: optimize only prompts and context without orchestration governance."/>
        <node TEXT="Benefit: quick improvements with minimal workflow change."/>
        <node TEXT="Cost: persistent long-task instability and unclear closure quality."/>
        <node TEXT="Decision guidance: prioritize harness controls once work crosses multiple iterations or modules."/>
      </node>
    </node>

    <node TEXT="Page 6 - Practical Blueprint for Reliable Agent Delivery">
      <node TEXT="Concept Deep Dive">
        <node TEXT="Production reliability requires bounded loops, test gates, and explicit human approval touchpoints."/>
        <node TEXT="Cloud agents extend runtime independence, while notifications keep humans informed asynchronously."/>
        <node TEXT="Recurring automation should be layered on only after deterministic verification is stable."/>
      </node>
      <node TEXT="Worked Example">
        <node TEXT="Scenario: A site auto-updates model listings daily and opens pull requests with validated diffs."/>
        <node TEXT="Inputs: scheduled trigger, scoped update routine, regression tests, and notification channel."/>
        <node TEXT="Execution: agent runs in cloud, validates output, creates pull request, and sends team alert."/>
        <node TEXT="Result: content freshness improves without sacrificing governance or release confidence."/>
      </node>
      <node TEXT="Demo Walkthrough">
        <node TEXT="Goal">
          <node TEXT="Demonstrate end-to-end autonomous maintenance with approval-based production control."/>
        </node>
        <node TEXT="Setup">
          <node TEXT="Configure scheduler, repository permissions, test gate, and communication integration."/>
        </node>
        <node TEXT="Steps">
          <node TEXT="Trigger update run, evaluate tests, open pull request, notify reviewers, and merge on approval."/>
        </node>
        <node TEXT="Expected Result">
          <node TEXT="The workflow produces repeatable updates with clear audit trail and minimal manual burden."/>
        </node>
        <node TEXT="Why this works">
          <node TEXT="The cycle aligns automation speed with controlled decision points."/>
        </node>
      </node>
      <node TEXT="Advanced Scenario">
        <node TEXT="Scenario setup: Multi-repository maintenance with varied update frequencies and release windows."/>
        <node TEXT="Constraints: cross-repo dependencies, notification fatigue, and approval bottlenecks."/>
        <node TEXT="Recommended decision: stagger schedules, centralize dashboards, and tier approval policies by risk."/>
        <node TEXT="Concept-backed answer: governance-aware automation scales sustainably when loops stay bounded."/>
      </node>
      <node TEXT="Trade-offs">
        <node TEXT="Option: fully autonomous merges without human checkpoints."/>
        <node TEXT="Benefit: maximum velocity and low operational overhead."/>
        <node TEXT="Cost: elevated governance and regression risk for high-impact changes."/>
        <node TEXT="Decision guidance: keep human approval for medium and high-risk changes while automating low-risk paths."/>
      </node>
    </node>
  </node>
</map>
