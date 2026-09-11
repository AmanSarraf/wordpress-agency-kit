# hostinger-mcp-deploy

Reusable **agent skill** for deploying WordPress **and** sibling PHP apps (POS, billing, custom PHP) on **Hostinger** shared hosting via Hostinger MCP / API.

This is **not** a WordPress plugin. It is documentation + procedures an AI coding agent (Grok, Claude Code, Cursor) loads so every developer on the team deploys the same way.

## What it covers

- Connect Hostinger MCP (Grok / Claude / Cursor)
- Create MySQL DB + upload PHP apps next to WordPress
- Avoid `wp-content` mistakes and bad `public_html` unzips
- Production recovery lessons
- Client handover TXT template
- Emergency bcrypt admin reset via phpMyAdmin

## Install for other developers

### Option A — Whole agency skills pack (recommended)

Clone or pull `wordpress-agency`, then point your agent at:

```text
wordpress-agency/.claude/skills/
```

**Claude Code:** open the agency repo (or a client repo that vendors these skills).  
**Grok:** add to `~/.grok/config.toml`:

```toml
[skills]
paths = ["/ABS/PATH/TO/wordpress-agency/.claude/skills"]

[mcp_servers.hostinger]
command = "npx"
args = ["-y", "@hostinger/mcp"]
enabled = true
```

Then once:

```bash
npx -y @hostinger/mcp --login
grok mcp doctor hostinger
```

### Option B — This skill only

Copy or symlink this folder:

```bash
mkdir -p ~/.grok/skills
ln -s /ABS/PATH/TO/wordpress-agency/.claude/skills/hostinger-mcp-deploy \
  ~/.grok/skills/hostinger-mcp-deploy
```

Same for Claude: place under `~/.claude/skills/hostinger-mcp-deploy` if you use user-level skills.

### Option C — Cursor

Install **Hostinger Connector** (or configure MCP JSON), and ensure this skill directory is on the agent’s skill path / project instructions.

## Layout

```text
hostinger-mcp-deploy/
  SKILL.md                          # agent entrypoint
  README.md                         # this file (humans)
  references/
    grok-and-claude-wiring.md
    sibling-php-app-deploy.md
    tus-upload-and-permissions.md
    safety-and-secrets.md
    production-lessons.md
  templates/
    CLIENT-HANDOVER-TEMPLATE.txt
```

## Typical agent prompt

> Deploy this PHP app to Hostinger next to the existing WordPress site under `/billing/`. Create a fresh DB, upload, migrate, seed admin, write a client handover TXT. Use the hostinger-mcp-deploy skill.

## Related

- Agency `CLAUDE.md` — sibling PHP rule + Hostinger MCP row  
- Skill `wp-wpcli-and-ops` — WordPress CLI ops (escalates here for Hostinger hosting)

## License / reuse

Internal agency skill; share with contractors by giving them this folder + Hostinger account access (OAuth). Do not bake client passwords into the skill itself — use per-client untracked env / handover files.
