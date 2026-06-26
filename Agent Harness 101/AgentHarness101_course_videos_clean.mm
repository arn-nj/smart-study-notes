<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0.1">
  <node TEXT="Agent Harness 101">
    <node TEXT="From Prompt Engineering to Context Engineering" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="One-shot prompting can give a polished answer for a small question, but it struggles when the task requires many dependent implementation decisions."/>
        <node TEXT="One-shot prompt -> shallow answer"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Prompt engineering defines one control surface."/>
        <node TEXT="Context engineering defines another control surface."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Start with the broad request."/>
        <node TEXT="Introduce selective file and knowledge loading."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="The result was not a replacement for prompting but a more reliable wrapper around it."/>
        <node TEXT="Ask for a one-shot feature plan."/>
      </node>
    </node>
    <node TEXT="Tool Calling, MCP, and RAG as Context Controls" ARCHETYPE="type_c" SCALE="macro">
      <node TEXT="Functional Mechanics">
        <node TEXT="Tool calling lets the model inspect only the files or actions relevant to the current task."/>
        <node TEXT="MCP-style integrations expose structured provider or platform capabilities instead of forcing everything through plain text."/>
      </node>
      <node TEXT="Concrete Configuration &amp; Code Snippets">
        <node TEXT="Tool calling -> relevant files/actions"/>
        <node TEXT="Identify the source needed for the current step."/>
      </node>
      <node TEXT="Edge Cases &amp; System Constraints">
        <node TEXT="These techniques improved quality, but they still did not guarantee reliable completion on very long tasks."/>
        <node TEXT="Explain why each source should stay out of the base prompt."/>
      </node>
    </node>
    <node TEXT="The Summarization Trap in Long-Running Tasks" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Run a long task until context fills."/>
        <node TEXT="Compress previous state into a summary."/>
        <node TEXT="Compare the summary with the original checklist."/>
        <node TEXT="Re-open work that was assumed complete."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="An agent spends hours implementing a feature, summarizes midway, and later assumes a half-tested workflow was already done."/>
        <node TEXT="Long task -> context fills"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="That distortion creates false completion signals where the agent believes a step was verified when it was only partially attempted."/>
        <node TEXT="Compress it into five bullets."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="The visible output may look complete, but hidden defects remain because compression replaced verification."/>
        <node TEXT="False done -> broken product quality"/>
      </node>
    </node>
    <node TEXT="Harness Engineering as a Controlled Iteration Loop" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Generate the requirements artifact."/>
        <node TEXT="Break work into atomic tasks."/>
        <node TEXT="Run one task inside a bounded loop."/>
        <node TEXT="Test and document the result."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="Instead of asking for an entire product in one go, the system works through requirement cards one by one and validates each card before moving on."/>
        <node TEXT="Requirements doc -> task queue"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Each loop selects one task, executes it, tests it, documents the result, and then resets before the next iteration."/>
        <node TEXT="Split it into five independently testable tasks."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Fresh context per loop reduces long-horizon drift because the agent no longer carries an ever-growing memory burden."/>
        <node TEXT="Fresh context each iteration"/>
      </node>
    </node>
    <node TEXT="How Prompt, Context, and Harness Layers Fit Together" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="Prompt engineering still matters because the system prompt defines the role, tone, and behavioral guardrails of the coding agent."/>
        <node TEXT="Prompt -> identity/rules"/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Prompt layer defines one control surface."/>
        <node TEXT="Context layer defines another control surface."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Define the agent persona and rules."/>
        <node TEXT="Wrap both inside a bounded execution loop."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="That layered design is why strong harnesses are often lightweight: they orchestrate rather than overstuff the prompt."/>
        <node TEXT="Describe one behavior that belongs to the prompt layer."/>
      </node>
    </node>
    <node TEXT="From Cloud Agents to Autonomous Production Cycles" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="Accept a request from a user, integration, or schedule."/>
        <node TEXT="Run the bounded harness loop in the cloud."/>
        <node TEXT="Emit a concrete artifact such as a PR or status update."/>
        <node TEXT="Repeat on a recurring cadence when the task is periodic."/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="A website needs daily model updates, so the cloud agent should detect changes, run the work, and open a pull request without a developer babysitting the process."/>
        <node TEXT="Request trigger -> cloud run"/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="This shifts the system from assistant-style interaction toward operational automation with explicit output handoff points."/>
        <node TEXT="Define the artifact that proves completion."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="That production orientation is what separates a clever demo from a dependable autonomous workflow."/>
        <node TEXT="Scheduled rerun -> autonomous upkeep"/>
      </node>
    </node>
  </node>
</map>