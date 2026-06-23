# Workflow Plan — AgentHarness101 automatic visual reasoning enrichment

## Inputs
- `Agent Harness 101/AgentHarness101_visual_briefs.json`
- `copilot-skills/skills/content-to-sketch/references/automatic-visual-reasoning.md`
- `copilot-skills/skills/content-to-sketch/references/canonical-scene-families.md`
- existing premium/semantic sketch package for Agent Harness 101

## Outputs
- refreshed `AgentHarness101_visual_briefs.json`
- refreshed `checkpoints/status.md`

## Execution order
1. Read the automatic visual reasoning reference.
2. For each of the 6 lessons, classify `diagramIntent`.
3. Select the best `formalFramework` for the concept.
4. Add 2-3 `sceneFamilyCandidates`, choose `selectedSceneFamily`, and record `selectionReason`.
5. Add `formalCompanionSuggested`, `salienceGoal`, `silhouetteContrastRules`, `propInventory`, and `textureInventory`.
6. Record checkpoint results.

## Checkpoint expectations
- **P** PASS: plan exists before brief enrichment starts.
- **B** PASS: all 6 lessons contain the new automatic-visual-reasoning fields.
- **K** PASS: AgentHarness101 brief package is ready for future reruns using the automatic visual reasoning layer.

## Rollback / retry strategy
- If a lesson's selected scene family feels weak, revise the candidate ranking and selection reason before touching downstream geometry.
- If a lesson clearly needs a formal companion, mark it even if no companion diagram is generated yet.
