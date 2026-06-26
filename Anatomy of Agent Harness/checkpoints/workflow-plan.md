# Workflow Plan — AnatomyOfAgentHarness full-set arrow audit

## Inputs
- all 19 Anatomy `.excalidraw` scenes under `Anatomy of Agent Harness/assets/`
- connector hygiene rules from `content-to-sketch`
- browser-based Excalidraw compile path via Windows Node + Chrome

## Outputs
- connector-cleaned `.excalidraw` scenes across the full Anatomy set
- refreshed `.png` files
- refreshed `assets/validation_report.txt`
- regenerated `AnatomyOfAgentHarness_GoodNotes_detailed_A4.pdf`
- refreshed `checkpoints/status.md`

## Execution order
1. Keep the already-audited premium 6 scenes intact.
2. Apply the same connector hygiene pass to the remaining 13 Anatomy scenes.
3. Recompile all Anatomy PNGs through browser-based Excalidraw export.
4. Validate PNG integrity and regenerate the PDF.
5. Record checkpoint results.

## Checkpoint expectations
- **P** PASS: plan exists before the full-set audit starts.
- **C** PASS: all 19 Anatomy scenes now have arrow auditing applied, with the premium 6 preserved and the remaining 13 cleaned.
- **D** PASS: all 19 PNGs compile and validate.
- **E** PASS: PDF regenerates successfully.
- **K** PASS: full-set arrow audit completes without fallback renderer.

## Rollback / retry strategy
- If an automatic reroute hurts readability on a non-premium scene, restore only that scene and adjust its connectors manually.
- If compile fails in WSL, reroute to Windows Node + Chrome with explicit CDN runtime.
- If PDF export fails, preserve the refreshed assets and rerun only the markdown-to-PDF step.
