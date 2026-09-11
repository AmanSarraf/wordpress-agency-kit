---
name: agency-bootstrap
description: "Use when starting WordPress Agency Kit work: first-time setup, checking if Docker/Git are installed, creating a new client project folder, allocating ports, or the user says new client, doctor, scaffold, or where to put projects. Run bin/wp-agency doctor before other WP work when the environment is unknown."
---

# Agency bootstrap

## First actions

1. From the kit root run `./bin/wp-agency doctor`.
2. If it prints `[x]`, show the printed install hints. Do **not** `sudo` install silently.
3. Re-run doctor until exit 0 (or Docker daemon started).
4. Create a client: `./bin/wp-agency new <slug> --from empty|html|wp-zip [--zip PATH]`.
5. `cd` into the new folder under `WP_AGENCY_CLIENTS_DIR` (default `../client-projects/<slug>`) and `docker compose up -d` after the user agrees.

## Folder convention

```text
wordpress-agency-kit/     ← this product (cloned)
../client-projects/<slug>/
  CLAUDE.md               ← ports + status
  docker-compose.yml
  .env                    ← never commit
  themes/ plugins/ html-template/
```

Override clients dir with `WP_AGENCY_CLIENTS_DIR`.

## Ports

`wp-agency new` picks the next free `WP_PORT` (8080, 8082, …). `wp-agency ports` lists them. Sibling PHP apps (billing) use extra compose services and their own ports — document in the client CLAUDE.md; they are not the WP_PORT grid.

## WP-CLI

Always exec into the **wordpress** container (not a separate wpcli service):

```bash
docker compose exec wordpress bash -c \
  "php wp-cli.phar <command> --allow-root --path=/var/www/html"
```

Download `wp-cli.phar` once per container if missing.
