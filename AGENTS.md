# WordPress Agency Kit — instructions for AI coding agents

You are helping a developer run an **AI-assisted WordPress agency**. This repo is a **kit**, not a WordPress plugin.

## First run (every new machine)

1. Skill **agency-bootstrap**: run `./bin/wp-agency doctor` from the kit root.
2. If doctor fails, show its install hints (Docker Desktop, Git). Do not silent-sudo.
3. Create work with `./bin/wp-agency new <slug> --from empty|html|wp-zip`.
4. Client code lives in `WP_AGENCY_CLIENTS_DIR` (default `../client-projects/<slug>`), **not** inside this kit.

## Two start modes

| User has | Skill | Command |
|---|---|---|
| HTML/CSS/Bootstrap zip | `html-to-classic-theme` | `new <slug> --from html --zip FILE` |
| WordPress/Hostinger dump zip | `wp-zip-import` | `new <slug> --from wp-zip --zip FILE` |
| Nothing | `agency-bootstrap` | `new <slug> --from empty` |

Hostinger production + sibling PHP (POS/billing): skill **hostinger-mcp-deploy**. Never install those apps under `wp-content/`.

## WP-CLI

Exec into the **wordpress** container:

```bash
docker compose exec wordpress bash -c \
  "php wp-cli.phar <command> --allow-root --path=/var/www/html"
```

## Classic themes for HTML conversions

Enqueue assets, `wp_nav_menu()`, CPT plugin for editable homepage sections. See `html-to-classic-theme`.

## Skills in this kit (`skills/`)

agency-bootstrap, html-to-classic-theme, wp-zip-import, hostinger-mcp-deploy, wp-plugin-development, wp-block-development, wp-block-themes, wp-rest-api, wp-performance, wp-wpcli-and-ops, wp-abilities-audit, wp-abilities-verify.

## Secrets

Never commit `.env`, Hostinger tokens, or client handover files with passwords.
