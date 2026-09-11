# WordPress Agency Kit

**AI-assisted WordPress development for agencies and freelancers.**

Not a WordPress plugin. A **kit** your coding agent (Grok, Claude Code, Cursor, Codex, Copilot, OpenCode, …) reads so every developer on the team scaffolds, converts, and deploys WordPress the same way.

```text
HTML/CSS zip  ─┐
               ├─►  ./bin/wp-agency new  ─►  Docker WordPress  ─►  Hostinger
WP dump zip  ─┘         (local client folder)
```

## What you get

- **`bin/wp-agency doctor`** — checks Docker, Compose, Git; tells you how to install what’s missing
- **`bin/wp-agency new`** — creates `../client-projects/<slug>` with unique ports, `.env`, Compose, starter theme
- **Skills** for HTML→classic theme, WP zip import, plugins, blocks, REST, Hostinger sibling PHP apps (POS/billing)
- **`AGENTS.md`** so any agent follows the same rules

## 3-minute start

```bash
git clone <this-repo> wordpress-agency-kit
cd wordpress-agency-kit
./bin/wp-agency doctor          # install anything marked [x], then re-run
./bin/wp-agency new demo --from empty
cd ../client-projects/demo
docker compose up -d
# open http://localhost:8080 — WordPress installer
```

Open **this kit folder** (or the new client folder) in your AI agent and say:

> Follow AGENTS.md. Convert this HTML zip into a classic theme.

## Two workflows

| You have | Command | Then ask the agent to |
|---|---|---|
| ThemeForest / HTML template | `new shop --from html --zip template.zip` | Use skill **html-to-classic-theme** |
| Hostinger / `public_html` dump | `new shop --from wp-zip --zip site.zip` | Use skill **wp-zip-import** |

Docs: [HTML workflow](docs/workflow-html-template.md) · [WP zip workflow](docs/workflow-wp-zip.md) · [Where projects live](docs/project-layout.md)

## Multiple clients

Each project gets its own `COMPOSE_PROJECT_NAME` and ports (`8080/8081`, `8082/8083`, …).

```bash
./bin/wp-agency ports
```

## Point your agent here

[Grok / Claude / Cursor / Codex / Copilot](docs/install-agents.md)

Optional MCPs (Playwright, Context7, Hostinger): [docs/mcp.md](docs/mcp.md)

## Layout

```text
wordpress-agency-kit/
  bin/wp-agency          doctor | new | ports
  skills/                agent skills (also .claude/skills)
  templates/docker/      slim Compose + Agency Starter theme
  AGENTS.md              source of truth for every agent
  ../client-projects/    created on your machine, not inside the kit
```

## Requirements

- Git
- Docker Desktop / Engine with **Compose v2** (`docker compose`)
- `unzip` for html / wp-zip imports

`doctor` prints OS-specific install links if anything is missing. It never sudo-installs for you.

## License

MIT
