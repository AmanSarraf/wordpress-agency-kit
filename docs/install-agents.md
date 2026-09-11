# Point your AI agent at this kit

Clone the kit, `cd` into it, then:

## Grok

```toml
# ~/.grok/config.toml
[skills]
paths = ["/ABS/PATH/wordpress-agency-kit/skills"]
```

Open the kit folder (or a client project) as the workspace. Read `AGENTS.md`.

Optional Hostinger MCP: `npx -y @hostinger/mcp --login` then add stdio server `npx -y @hostinger/mcp`.

## Claude Code

Open the kit repo. `CLAUDE.md` + `.claude/skills` → `skills/` already.

```bash
claude mcp add --transport http hostinger https://mcp.hostinger.com   # optional
```

## Cursor

Open the kit. Rule: `.cursor/rules/wordpress-agency-kit.mdc`. Add Hostinger Connector or MCP JSON as you prefer.

## Codex / Copilot / OpenCode

Open the kit so `AGENTS.md` and `.github/copilot-instructions.md` load. Run doctor in the terminal; the agent should follow AGENTS.md.
