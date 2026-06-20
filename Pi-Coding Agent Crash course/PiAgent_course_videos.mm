<map version="1.0.1">
<node TEXT="Pi Agent – Crash Course | Minimal Coding Agent" FOLDED="false">
  <node TEXT="Pi Agent Harness Overview" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Pi starts as a minimal harness with only a handful of built-in tools so the default surface area stays small and understandable"/>
      <node TEXT="It intentionally leaves out MCP, sub-agents, permission pop-ups, plan mode, and built-in to-dos until you add them"/>
      <node TEXT="Pi behaves like a foundation layer that grows with your workflow instead of forcing a complete product bundle at install time"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: install Pi and run it immediately from the CLI with no further configuration"/>
      <node TEXT="Inputs: fresh install, no added models, no custom extensions"/>
      <node TEXT="Execution: Pi loads the default harness and minimal tool set"/>
      <node TEXT="Result: you can begin using the harness first and extend it later when a real need appears"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Show how Pi starts simple and grows only when configured"/>
      <node TEXT="Setup"/>
      <node TEXT="Fresh installation with default settings"/>
      <node TEXT="Steps"/>
      <node TEXT="Open Pi, inspect built-in tools, compare with a fuller agent harness"/>
      <node TEXT="Expected Result"/>
      <node TEXT="Pi presents a compact default environment"/>
      <node TEXT="Why this works"/>
      <node TEXT="The harness is designed as a base layer, not a fixed feature bundle"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a developer wants a harness that stays small on day one but can later support automation, safety checks, and local workflows"/>
      <node TEXT="Constraints: avoid early feature bloat; keep the first install easy to understand"/>
      <node TEXT="Recommended decision: keep the base install minimal and add features only when a real workflow requires them"/>
      <node TEXT="Concept-backed answer: Pi is intentionally extensible so the harness can be shaped after install"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Minimal default harness versus feature-heavy harness"/>
      <node TEXT="Small start is easier to learn, but requires later setup for advanced workflows"/>
      <node TEXT="A growing harness is flexible, but the user must choose what to add"/>
    </node>
  </node>
  <node TEXT="Login, Models, and Scopes" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Pi installs without models, so login is required before it becomes useful"/>
      <node TEXT="Login can happen through a subscription or an API key, and once authenticated Pi exposes models from multiple providers"/>
      <node TEXT="The selector separates all available models from scoped favorites so you can switch quickly during work"/>
      <node TEXT="Thinking level is another control layer for models that support minimal, low, medium, and high reasoning modes"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: authenticate with Hugging Face and use Minimax for a demo"/>
      <node TEXT="Inputs: API key, several available providers, one favorite model list"/>
      <node TEXT="Execution: login, open the model chooser, mark scoped models, select a thinking level"/>
      <node TEXT="Result: faster model switching and a reasoning depth matched to the task"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Demonstrate provider login, scoped models, and thinking controls"/>
      <node TEXT="Setup"/>
      <node TEXT="Pi logged in with one provider"/>
      <node TEXT="Steps"/>
      <node TEXT="Open model chooser, add a scoped model, switch thinking level"/>
      <node TEXT="Expected Result"/>
      <node TEXT="Scoped models are quickly accessible and thinking modes can be changed when supported"/>
      <node TEXT="Why this works"/>
      <node TEXT="Model selection is separated from the harness core so providers and reasoning depth can vary without changing the UI flow"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a team uses one model for quick edits and another for deep planning"/>
      <node TEXT="Constraints: minimize switching friction without losing access to other providers"/>
      <node TEXT="Recommended decision: keep the most common models scoped and leave the rest in the full list"/>
      <node TEXT="Concept-backed answer: scoped models are the practical shortcut for everyday use"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="All models versus scoped favorites"/>
      <node TEXT="Broad access is flexible, but scoped favorites are faster during daily work"/>
      <node TEXT="Higher thinking levels can improve reasoning, but cost more time"/>
    </node>
  </node>
  <node TEXT="Prompt Templates" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Prompt templates behave like reusable commands that expand into a larger prompt"/>
      <node TEXT="Pi can create these templates for you by reading its own documentation and writing a workspace-specific prompt"/>
      <node TEXT="Templates are valuable because they encode repeatable workflows once and let you reuse them consistently"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: create a detailed code review prompt"/>
      <node TEXT="Inputs: request for a thorough review workflow"/>
      <node TEXT="Execution: Pi reads its docs, creates the prompt, and stores it in the prompt directory"/>
      <node TEXT="Result: typing the prompt name expands into the full code review instruction set"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Create and reuse a code review template"/>
      <node TEXT="Setup"/>
      <node TEXT="Pi open in a workspace"/>
      <node TEXT="Steps"/>
      <node TEXT="Ask Pi to create a prompt, reload, run the new slash command"/>
      <node TEXT="Expected Result"/>
      <node TEXT="The new template appears and expands on command"/>
      <node TEXT="Why this works"/>
      <node TEXT="Templates are stored in configuration files and loaded again after reload"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a developer repeats the same review checklist every day"/>
      <node TEXT="Constraints: do not want to retype the same instructions"/>
      <node TEXT="Recommended decision: keep a reusable review prompt with variables"/>
      <node TEXT="Concept-backed answer: prompt templates reduce repetition and standardize workflow quality"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Manual prompt typing versus reusable templates"/>
      <node TEXT="Templates add setup work once, but save time every later use"/>
      <node TEXT="Workspace templates are local and targeted, but require maintenance"/>
    </node>
  </node>
  <node TEXT="Skills and Command Execution" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Pi discovers skills from multiple places: home and workspace .agents directories, .clote, and Pi-specific skill folders"/>
      <node TEXT="The slash skill picker exposes the loaded skills for direct execution inside Pi"/>
      <node TEXT="Terminal commands use ! to include the command in history and !! to run it without adding it to the conversation context"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: a workspace skill visualizer and a video tool are both available"/>
      <node TEXT="Inputs: skills in home and workspace directories"/>
      <node TEXT="Execution: Pi loads the skills, runs the visualizer, and opens the generated result"/>
      <node TEXT="Result: you can inspect what skills are available and keep command noise out of context when needed"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Load and run a skill, then compare ! and !! shell behavior"/>
      <node TEXT="Setup"/>
      <node TEXT="One or more skills in the Pi skill search paths"/>
      <node TEXT="Steps"/>
      <node TEXT="Open Pi, select a skill, run one harmless command with ! and another with !!"/>
      <node TEXT="Expected Result"/>
      <node TEXT="The skill runs and the shell command history behaves differently depending on prefix"/>
      <node TEXT="Why this works"/>
      <node TEXT="Pi treats commands as either context-worthy or context-free based on the prefix"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: one skill is meant to be shared globally while another should stay repo-specific"/>
      <node TEXT="Constraints: preserve reuse without leaking project-specific behavior"/>
      <node TEXT="Recommended decision: keep shared skills in home .agents and local skills in the workspace"/>
      <node TEXT="Concept-backed answer: the multi-location search path makes Pi modular across projects"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="! versus !! shell execution"/>
      <node TEXT="Including commands in history improves traceability, but can clutter context"/>
      <node TEXT="Multiple skill search paths increase flexibility, but require directory discipline"/>
    </node>
  </node>
  <node TEXT="Themes and UI Customization" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Pi can change the terminal user interface through themes, not just behavior"/>
      <node TEXT="Built-in themes are simple, but Pi can generate a workspace theme that stays local to one project"/>
      <node TEXT="Reload is required after a theme update so the settings screen can show the new option"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: create a fun workspace theme called Gummi"/>
      <node TEXT="Inputs: theme request, current workspace"/>
      <node TEXT="Execution: Pi generates the theme and saves it for the current workspace"/>
      <node TEXT="Result: the UI updates after reload and the new colors appear in settings"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Create a workspace theme and activate it"/>
      <node TEXT="Setup"/>
      <node TEXT="Pi open in a workspace"/>
      <node TEXT="Steps"/>
      <node TEXT="Ask Pi to create a theme, reload Pi, select the theme from settings"/>
      <node TEXT="Expected Result"/>
      <node TEXT="The new theme appears and the UI palette changes"/>
      <node TEXT="Why this works"/>
      <node TEXT="Theme data is stored as configuration and only becomes visible after reload"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: you want a playful theme for one repo but keep the rest of your setup unchanged"/>
      <node TEXT="Constraints: avoid global side effects"/>
      <node TEXT="Recommended decision: scope the theme to the workspace"/>
      <node TEXT="Concept-backed answer: workspace-scoped UI changes keep experimentation isolated"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Built-in theme versus custom workspace theme"/>
      <node TEXT="Custom themes improve usability and fun, but need manual maintenance"/>
      <node TEXT="Workspace scoping prevents global disruption"/>
    </node>
  </node>
  <node TEXT="Context Files" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Pi follows the agents.md pattern and also reads clod.md so it can merge multiple instruction sources automatically"/>
      <node TEXT="Workspace context files encode project-specific guidance, while home context files act like defaults across all projects"/>
      <node TEXT="Home files are powerful because they influence many sessions, so they should contain only truly universal preferences"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: workspace says be concise and prioritize tests; home file says include deployment notes"/>
      <node TEXT="Inputs: agents.md and clod.md in both workspace and home locations"/>
      <node TEXT="Execution: Pi loads both sets and merges them into context"/>
      <node TEXT="Result: the agent responds using the combined instruction set"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Compare workspace versus home instruction influence"/>
      <node TEXT="Setup"/>
      <node TEXT="One workspace and one home context file"/>
      <node TEXT="Steps"/>
      <node TEXT="Edit a preference in the workspace file, then another in the home file, and ask a question in Pi"/>
      <node TEXT="Expected Result"/>
      <node TEXT="Pi follows both sources and merges the instructions"/>
      <node TEXT="Why this works"/>
      <node TEXT="Context is assembled from multiple files before the model call"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a team wants a global style guide but different instructions per repository"/>
      <node TEXT="Constraints: home rules must not override repo rules in every case"/>
      <node TEXT="Recommended decision: keep broad preferences in home files and detailed policies in workspace files"/>
      <node TEXT="Concept-backed answer: the same file system search path gives you both global defaults and project-specific overrides"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Home context versus workspace context"/>
      <node TEXT="Home files are reusable, but can affect too many sessions"/>
      <node TEXT="Workspace files are safer for repo-specific behavior"/>
    </node>
  </node>
  <node TEXT="Extensions" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Extensions add behaviour after installation without changing the core harness"/>
      <node TEXT="They can alter startup, display quotes, change the editor, or intercept dangerous commands"/>
      <node TEXT="A guard extension can inspect shell commands and ask for confirmation before destructive actions like rm -rf or git push --force"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: create a workspace extension that prints a welcome quote and guards dangerous commands"/>
      <node TEXT="Inputs: a startup message and a list of disallowed command patterns"/>
      <node TEXT="Execution: Pi writes the extension, reloads, and activates the hooks"/>
      <node TEXT="Result: a startup quote appears and rm -rf is blocked until confirmed"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Create and test a command guard extension"/>
      <node TEXT="Setup"/>
      <node TEXT="Workspace with a small test directory"/>
      <node TEXT="Steps"/>
      <node TEXT="Ask Pi to create the extension, reload, try a destructive command"/>
      <node TEXT="Expected Result"/>
      <node TEXT="Pi pauses and asks for confirmation before the command executes"/>
      <node TEXT="Why this works"/>
      <node TEXT="Extensions can intercept workflows before the shell action is allowed to complete"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a coding agent should prevent accidental force pushes and recursive deletes"/>
      <node TEXT="Constraints: keep productive shell access, but add strong guard rails"/>
      <node TEXT="Recommended decision: implement a confirmation guard for specific patterns only"/>
      <node TEXT="Concept-backed answer: extensions turn Pi into a custom safety layer rather than a fixed product"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Baseline Pi is simple; extensions add power but also maintenance"/>
      <node TEXT="Safety extensions reduce risk, but add confirmation friction"/>
      <node TEXT="Workspace extensions keep behavior local and easier to reason about"/>
    </node>
  </node>
  <node TEXT="Packages" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Packages bundle prompts, skills, extensions, and related scripts into a single installable capability set"/>
      <node TEXT="They provide a curated install path for common workflows like web search, MCP support, and sub-agent helpers"/>
      <node TEXT="Because packages may contain scripts, they should be inspected before trust is granted"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: add MCP support, web search, and sub-agent helpers in one step"/>
      <node TEXT="Inputs: a trusted package that bundles those components"/>
      <node TEXT="Execution: install the package and let it add the relevant prompts and scripts"/>
      <node TEXT="Result: the harness gains a capability family instead of a single feature"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Inspect and install one package"/>
      <node TEXT="Setup"/>
      <node TEXT="Pi open in a workspace"/>
      <node TEXT="Steps"/>
      <node TEXT="Browse package list, open its contents, install only if trusted"/>
      <node TEXT="Expected Result"/>
      <node TEXT="The package contributes multiple related capabilities at once"/>
      <node TEXT="Why this works"/>
      <node TEXT="Packages are bundles, so related behavior ships together instead of being wired manually"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: you want a ready-made web search stack but must avoid untrusted scripts"/>
      <node TEXT="Constraints: package may contain executable code"/>
      <node TEXT="Recommended decision: inspect package contents before installing"/>
      <node TEXT="Concept-backed answer: the package model is powerful, but trust boundaries still matter"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Bundled install versus manual assembly"/>
      <node TEXT="Bundles save time, but the user inherits whatever scripts are included"/>
      <node TEXT="Curated packages are convenient, but should be reviewed like any other dependency"/>
    </node>
  </node>
  <node TEXT="Sessions and Thread Management" POSITION="right">
    <node TEXT="Concept Deep Dive">
      <node TEXT="Sessions make Pi threads recoverable, inspectable, and branchable"/>
      <node TEXT="You can rename sessions, inspect their path, navigate a tree of messages, fork a thread, clone the current position, compact the conversation, and export the result"/>
      <node TEXT="Export turns a live chat into a file you can archive, reuse, or analyze outside Pi"/>
    </node>
    <node TEXT="Worked Example">
      <node TEXT="Scenario: you send one wrong message, then want to continue from the last good assistant turn"/>
      <node TEXT="Inputs: active session, tree navigation, fork or clone action"/>
      <node TEXT="Execution: move backward in the tree, branch the session, continue on the new branch"/>
      <node TEXT="Result: you recover without losing the useful part of the conversation"/>
    </node>
    <node TEXT="Demo Walkthrough">
      <node TEXT="Goal"/>
      <node TEXT="Rename, inspect, branch, and export a session"/>
      <node TEXT="Setup"/>
      <node TEXT="Pi open with an active conversation"/>
      <node TEXT="Steps"/>
      <node TEXT="Use slash name, inspect slash session, navigate the tree, then export"/>
      <node TEXT="Expected Result"/>
      <node TEXT="The session has a name, a file path, and an exportable history"/>
      <node TEXT="Why this works"/>
      <node TEXT="Pi stores session history in a navigable structure rather than a single opaque chat log"/>
    </node>
    <node TEXT="Advanced Scenario">
      <node TEXT="Scenario setup: a long debugging conversation has drifted off target and needs recovery"/>
      <node TEXT="Constraints: do not lose the productive branch"/>
      <node TEXT="Recommended decision: fork the session at the last good point and continue from there"/>
      <node TEXT="Concept-backed answer: session tree controls let you branch safely instead of restarting from scratch"/>
    </node>
    <node TEXT="Trade-offs">
      <node TEXT="Tree navigation versus linear chat"/>
      <node TEXT="Branching increases recovery power, but adds more moving parts"/>
      <node TEXT="Export is useful for reuse, but creates an extra artifact to manage"/>
    </node>
  </node>
</node>
</map>
