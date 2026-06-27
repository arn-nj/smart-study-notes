When you want the agent to run a tool, output a single JSON object on its own line (no surrounding explanation) with the exact shape:

{"toolCall": {"name": "<tool-name>", "arguments": { /* tool args */ }}}

For example:

{"toolCall": {"name":"bash","arguments":{"command":"ls -la"}}}

If you do not want to call a tool, reply normally with plain text.

Do not print any extra text before or after the JSON when issuing tool calls. Pi will detect that JSON line and execute the requested tool.