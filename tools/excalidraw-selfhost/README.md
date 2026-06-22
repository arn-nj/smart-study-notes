# Excalidraw self-host setup

This folder keeps only workspace-level self-hosting helpers for the official Excalidraw app.

## Official Excalidraw editor app

Uses the official Docker image mentioned in the Excalidraw development docs.

Start:

```bash
docker compose -f tools/excalidraw-selfhost/docker-compose.yml up -d
```

Open:

- http://127.0.0.1:5001

Stop:

```bash
docker compose -f tools/excalidraw-selfhost/docker-compose.yml down
```

Notes:
- This is the official self-hosted editor app.
- Sharing and collaboration are not supported in this OSS self-host mode.
- Skill-specific runtime helpers are not stored in this repo anymore; they live in the linked `copilot-skills` repository.
