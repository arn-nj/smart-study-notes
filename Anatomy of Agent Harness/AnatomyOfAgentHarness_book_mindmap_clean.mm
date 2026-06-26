<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0.1">
  <node TEXT="The Anatomy of an Agent Harness">
    <node TEXT="Foundation Models Changed the Build Sequence" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="foundation-model APIs removing model-training bottlenecks so agent design moves earlier in the product lifecycle"/>
        <node TEXT="Foundation Models Changed the Build Sequence explains foundation-model APIs removing model-training bottlenecks so agent design moves earlier in the product lifecycle."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Foundation models is a major control surface."/>
        <node TEXT="Foundations defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Canvas Planning Shows the Demo-to-Production Gap" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="separate planning canvases exposing the difference between a proof-of-concept agent and a production-ready one"/>
        <node TEXT="Canvas Planning Shows the Demo-to-Production Gap explains separate planning canvases exposing the difference between a proof-of-concept agent and a production-ready one."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="POC canvas is a major control surface."/>
        <node TEXT="Foundations defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="What the Agent Harness Actually Is" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="the complete software infrastructure around the model producing agent behavior"/>
        <node TEXT="What the Agent Harness Actually Is explains the complete software infrastructure around the model producing agent behavior."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Agent harness is a major control surface."/>
        <node TEXT="Definition defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Prompt, Context, and Harness Engineering" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="three concentric engineering layers around the model with increasing scope and control"/>
        <node TEXT="Prompt, Context, and Harness Engineering explains three concentric engineering layers around the model with increasing scope and control."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Prompt engineering is a major control surface."/>
        <node TEXT="Definition defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="The Orchestration Loop" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="The 11 Components"/>
        <node TEXT="A coding task requires multiple rounds of model calls and tool execution before it can be considered complete."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="Tools" ARCHETYPE="type_c" SCALE="macro">
      <node TEXT="Functional Mechanics">
        <node TEXT="schema-driven external actions that give the agent hands and interfaces"/>
        <node TEXT="Tools"/>
      </node>
      <node TEXT="Concrete Configuration &amp; Code Snippets">
        <node TEXT="Define the runtime interface cleanly."/>
        <node TEXT="Constrain outputs structurally when possible."/>
      </node>
      <node TEXT="Edge Cases &amp; System Constraints">
        <node TEXT="Weak implementation here can break downstream orchestration."/>
        <node TEXT="Runtime ambiguity compounds over long tasks."/>
      </node>
    </node>
    <node TEXT="Memory" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="multi-timescale storage hierarchy separating short-term conversation state from persistent long-term knowledge"/>
        <node TEXT="Memory explains multi-timescale storage hierarchy separating short-term conversation state from persistent long-term knowledge."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Memory is a major control surface."/>
        <node TEXT="The 11 Components defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Context Management" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="The 11 Components"/>
        <node TEXT="A million-token model still loses quality when too much low-signal material accumulates in the window."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="Prompt Construction" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="The 11 Components"/>
        <node TEXT="A system needs to decide not only what information to include, but where to place it in the final prompt payload."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="Output Parsing" ARCHETYPE="type_c" SCALE="macro">
      <node TEXT="Functional Mechanics">
        <node TEXT="classification of model output into final answer, structured tool call, or handoff"/>
        <node TEXT="Output Parsing"/>
      </node>
      <node TEXT="Concrete Configuration &amp; Code Snippets">
        <node TEXT="Define the runtime interface cleanly."/>
        <node TEXT="Constrain outputs structurally when possible."/>
      </node>
      <node TEXT="Edge Cases &amp; System Constraints">
        <node TEXT="Weak implementation here can break downstream orchestration."/>
        <node TEXT="Runtime ambiguity compounds over long tasks."/>
      </node>
    </node>
    <node TEXT="State Management" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="typed persistent state flowing through checkpoints so work can resume after interruptions"/>
        <node TEXT="State Management explains typed persistent state flowing through checkpoints so work can resume after interruptions."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="State Management is a major control surface."/>
        <node TEXT="The 11 Components defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Error Handling" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="The 11 Components"/>
        <node TEXT="A ten-step process with high per-step reliability still fails often enough end-to-end that unrecovered errors become a product problem."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="Guardrails and Safety" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="separation of model intent from permission enforcement with tripwires and policy checks"/>
        <node TEXT="Guardrails and Safety explains separation of model intent from permission enforcement with tripwires and policy checks."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Guardrails and Safety is a major control surface."/>
        <node TEXT="The 11 Components defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Verification Loops" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="The 11 Components"/>
        <node TEXT="A demo looks fine until tests, screenshots, or an independent reviewer prove that the behavior is actually broken."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="Subagent Orchestration" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="bounded delegation of subtasks to specialized or isolated agents without losing parent control"/>
        <node TEXT="Subagent Orchestration explains bounded delegation of subtasks to specialized or isolated agents without losing parent control."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Subagent Orchestration is a major control surface."/>
        <node TEXT="The 11 Components defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Step-by-Step Walkthrough and the Ralph Loop" ARCHETYPE="type_b" SCALE="macro">
      <node TEXT="Execution Pipeline / Steps">
        <node TEXT="trigger the cycle"/>
        <node TEXT="execute the bounded step"/>
        <node TEXT="package evidence"/>
        <node TEXT="loop or terminate"/>
      </node>
      <node TEXT="Environment Prerequisites &amp; Setup">
        <node TEXT="Synthesis"/>
        <node TEXT="A long-running coding task crosses multiple context windows, so the system needs a way to reorient the next session without replaying the whole conversation."/>
      </node>
      <node TEXT="Failure Recovery &amp; Verification">
        <node TEXT="Watch for drift, silent tool failure, or false completion."/>
        <node TEXT="Feed failures back as recoverable signals when possible."/>
      </node>
      <node TEXT="Performance Optimizations">
        <node TEXT="Prefer high-signal controls over giant unfiltered context."/>
        <node TEXT="Use bounded steps to keep runtime predictable."/>
      </node>
    </node>
    <node TEXT="How Frameworks Implement the Pattern" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="framework-specific surfaces exposing the same underlying harness pattern through different abstractions"/>
        <node TEXT="How Frameworks Implement the Pattern explains framework-specific surfaces exposing the same underlying harness pattern through different abstractions."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Code-first runner is a major control surface."/>
        <node TEXT="Synthesis defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Scaffolding, Co-Evolution, and the Future-Proofing Test" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="temporary-but-necessary harness complexity that should shrink as models internalize more behavior"/>
        <node TEXT="Scaffolding, Co-Evolution, and the Future-Proofing Test explains temporary-but-necessary harness complexity that should shrink as models internalize more behavior."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Scaffolding metaphor is a major control surface."/>
        <node TEXT="Synthesis defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
    <node TEXT="Seven Architectural Decisions and the Final Takeaway" ARCHETYPE="type_a" SCALE="macro">
      <node TEXT="Core Architecture Blueprint">
        <node TEXT="explicit harness-definition choices around agent count, execution style, context strategy, verification, safety, tool scope, and thickness"/>
        <node TEXT="Seven Architectural Decisions and the Final Takeaway explains explicit harness-definition choices around agent count, execution style, context strategy, verification, safety, tool scope, and thickness."/>
      </node>
      <node TEXT="Core Components &amp; Governance">
        <node TEXT="Harness thickness is a major control surface."/>
        <node TEXT="Synthesis defines the larger system grouping."/>
      </node>
      <node TEXT="Key Integration Points">
        <node TEXT="Map this chapter into loop + memory + safety interactions."/>
        <node TEXT="Connect it to adjacent harness layers."/>
      </node>
      <node TEXT="Systemic Trade-offs">
        <node TEXT="Too little structure weakens reliability."/>
        <node TEXT="Too much structure can add runtime overhead."/>
      </node>
    </node>
  </node>
</map>