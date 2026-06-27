import { spawnSync } from "child_process";
import fs from "fs";
import path from "path";
import { createAssistantMessageEventStream } from "@earendil-works/pi-ai";

// Minimal pi extension to register a local Ollama provider that supports tool calls.
// Configurable via environment variables:
//  - OLLAMA_MODEL_ID (default: ollama/qwen2.5-coder:7b)
//  - OLLAMA_CMD_PATH (default: ollama)
// Project settings (optional): .pi/settings.json
// {
//   "ollama": { "useHttp": true, "host": "127.0.0.1:11434" }
// }

export default function (pi: any) {
  const modelId = process.env.OLLAMA_MODEL_ID || "ollama/qwen2.5-coder:7b";
  const ollamaCmd = process.env.OLLAMA_CMD_PATH || "ollama";

  pi.registerProvider("ollama-local", {
    name: "Ollama (local)",
    baseUrl: "local",
    apiKey: "$OLLAMA_API_KEY",
    api: "openai-completions",
    models: [
      {
        id: modelId,
        name: modelId,
        reasoning: true,
        input: ["text"],
        cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
        contextWindow: 131072,
        maxTokens: 8192,
      },
    ],

    // streamSimple: implements a simple, non-streaming bridge to the ollama CLI.
    // It runs: ollama run <model> <prompt> --format json
    streamSimple: (model: any, context: any, options?: any) => {
      const stream = createAssistantMessageEventStream();

      (async () => {
        // Prepare an assistant message skeleton used as `partial` on events
        const output: any = {
          role: "assistant",
          content: [],
          api: model.api,
          provider: "ollama-local",
          model: model.id,
          usage: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0, totalTokens: 0 },
          stopReason: "stop",
          timestamp: Date.now(),
        };

        try {
          stream.push({ type: "start", partial: output });

          const msgs = (context?.messages || []).map((m: any) => {
            // content can be string or structured blocks; try to extract text
            let text = "";
            if (typeof m.content === "string") text = m.content;
            else if (Array.isArray(m.content)) text = m.content.map((b: any) => b.text || "").join("\n");
            else if (m.content && typeof m.content === "object") text = JSON.stringify(m.content);

            return `[${m.role}]\n${text}\n`;
          }).join("\n");

          const toolJsonInstruction = `\n\nWhen you want the agent to run a tool, output a single JSON object on its own line (no surrounding explanation) with the exact shape:\n{"toolCall": {"name": "<tool-name>", "arguments": { /* tool args */ }}}\nFor example:\n{"toolCall": {"name":"bash","arguments":{"command":"ls -la"}}}\nIf you do not want to call a tool, reply normally with plain text.\n`;

          const fullPrompt = `${msgs}\n${toolJsonInstruction}`.trim();

          // Ollama model names are usually like 'qwen2.5-coder:7b' (no provider prefix).
          // Strip any leading 'ollama/' prefix so the CLI or server can find the model locally.
          const ollamaModel = modelId.replace(/^ollama\//, "");

          // Determine HTTP usage and host from project settings or env vars.
          let useHttp = false;
          let host = process.env.OLLAMA_HOST || '127.0.0.1:11434';
          try {
            const settingsPath = path.join(process.cwd(), '.pi', 'settings.json');
            if (fs.existsSync(settingsPath)) {
              const cfg = JSON.parse(fs.readFileSync(settingsPath, 'utf8'));
              if (cfg && cfg.ollama) {
                if (typeof cfg.ollama.useHttp !== 'undefined') useHttp = !!cfg.ollama.useHttp;
                if (cfg.ollama.host) host = cfg.ollama.host;
              }
            }
          } catch (e) {
            // ignore
          }

          // Env var overrides settings
          if (typeof process.env.OLLAMA_USE_HTTP !== 'undefined') {
            useHttp = process.env.OLLAMA_USE_HTTP === '1' || process.env.OLLAMA_USE_HTTP === 'true';
          }
          if (process.env.OLLAMA_HOST) host = process.env.OLLAMA_HOST;

          let raw = "";

          if (useHttp) {
            try {
              const url = `http://${host}/v1/completions`;

              // Ollama completions expects { model, prompt, format? }
              const body = JSON.stringify({ model: ollamaModel, prompt: fullPrompt });

              // Use global fetch if available, otherwise throw to use CLI fallback
              if (typeof fetch === 'undefined') throw new Error('fetch not available, falling back to CLI');

              const resp = await fetch(url, { method: 'POST', body, headers: { 'Content-Type': 'application/json' }, signal: options?.signal });
              if (!resp.ok) throw new Error(`HTTP ${resp.status}: ${await resp.text()}`);
              raw = await resp.text();
            } catch (e) {
              // HTTP bridge failed — log and fall back to CLI
              // console.warn(e);
              raw = "";
            }
          }

          if (!raw) {
            // Fallback to CLI
            const args = ["run", ollamaModel, fullPrompt, "--format", "json"];
            const res = spawnSync(ollamaCmd, args, { encoding: "utf8", maxBuffer: 50 * 1024 * 1024 });

            if (res.error) throw res.error;

            raw = (res.stdout || "").trim() || (res.stderr || "").trim();
          }

          // Strip ANSI control sequences that Ollama may emit (spinners/progress)
          const clean = raw.replace(/\x1b\[[0-9;?]*[ -\/]*[@-~]/g, "");

          // Try parse JSON (ollama --format json or /v1/completions returns JSON)
          let parsed: any = null;
          try {
            parsed = JSON.parse(clean);
          } catch {
            // Not JSON — fall back to cleaned text
          }

          let replyText = "";
          if (parsed) {
            // Handle OpenAI-style completion responses from Ollama's /v1/completions
            if (Array.isArray(parsed.choices) && parsed.choices.length > 0 && typeof parsed.choices[0].text === 'string') {
              replyText = parsed.choices[0].text;
            } else {
              replyText = parsed.text || parsed.response || JSON.stringify(parsed);
            }
          } else replyText = clean;

          // If the model wrapped JSON in markdown code fences (```json ... ```), strip them
          replyText = replyText.replace(/^```json\s*/i, "").replace(/\s*```$/i, "");

          // Push text block events
          output.content.push({ type: "text", text: replyText });
          stream.push({ type: "text_start", contentIndex: 0, partial: output });
          stream.push({ type: "text_delta", contentIndex: 0, delta: replyText, partial: output });
          stream.push({ type: "text_end", contentIndex: 0, content: replyText, partial: output });

          // Robust JSON detection: find any balanced JSON object in the cleaned output
          // that contains a top-level `toolCall` key. This tolerates spinners, ANSI
          // escape sequences, multi-line JSON, and small surrounding text.
          function findToolCallJson(s: string) {
            // Remove remaining C0 control chars except newline/tab/carriage return
            const stripped = s.replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, "");

            for (let i = 0; i < stripped.length; i++) {
              if (stripped[i] !== '{') continue;

              let depth = 0;
              for (let j = i; j < stripped.length; j++) {
                const ch = stripped[j];
                if (ch === '{') depth++;
                else if (ch === '}') depth--;

                if (depth === 0) {
                  const candidate = stripped.slice(i, j + 1);
                  try {
                    const obj = JSON.parse(candidate);
                    if (obj && typeof obj === 'object' && 'toolCall' in obj) return obj;
                  } catch (e) {
                    // not valid JSON, continue searching
                  }
                  break; // stop inner loop, move to next opening brace
                }
              }
            }

            // fallback: try to parse any full-string JSON
            try {
              const obj = JSON.parse(stripped.trim());
              if (obj && typeof obj === 'object' && 'toolCall' in obj) return obj;
            } catch {}

            return null;
          }

          const toolObj = findToolCallJson(replyText || clean);

          if (toolObj && toolObj.toolCall && toolObj.toolCall.name) {
            const toolIndex = output.content.length;
            output.content.push({ type: "toolCall", id: String(Date.now()), name: toolObj.toolCall.name, arguments: toolObj.toolCall.arguments || {} });

            stream.push({ type: "toolcall_start", contentIndex: toolIndex, partial: output });
            // For toolcall_delta we send the JSON string as delta
            stream.push({ type: "toolcall_delta", contentIndex: toolIndex, delta: JSON.stringify(toolObj.toolCall.arguments || {}), partial: output });
            stream.push({ type: "toolcall_end", contentIndex: toolIndex, toolCall: { type: "toolCall", id: output.content[toolIndex].id, name: output.content[toolIndex].name, arguments: output.content[toolIndex].arguments }, partial: output });

            // After a toolcall, pi will run the tool and then continue the session flow.
          }

          stream.push({ type: "done", reason: "stop", message: output });
          stream.end();
        } catch (error: any) {
          output.stopReason = options?.signal?.aborted ? "aborted" : "error";
          output.errorMessage = error instanceof Error ? error.message : String(error);
          stream.push({ type: "error", reason: output.stopReason, error: output });
          stream.end();
        }
      })();

      return stream;
    },
  });

  // Helpful hint: register a small message_end hook that rewrites common ollama overflow errors
  pi.on?.("message_end", (event: any, ctx: any) => {
    const message = event?.message;
    if (!message || message.role !== "assistant") return;
    if (message.provider !== "ollama-local" && ctx?.model?.provider !== "ollama-local") return;

    const err = message.errorMessage ?? "";
    if (!err) return;

    // If Ollama returns a context overflow phrase not recognized by pi, normalize it
    if (/context.*length/i.test(err) && !err.includes("context_length_exceeded")) {
      return { message: { ...message, errorMessage: `context_length_exceeded: ${err}` } };
    }
  });
}
