---
name: wp-zip-import
description: "Use when importing a WordPress filesystem dump or Hostinger public_html zip into a local Agency Kit project: map wp-content themes/plugins/uploads, import SQL, search-replace URLs, keep sibling PHP apps (POS/billing) out of wp-content."
---

# WordPress ZIP dump → local kit project

## Create the project

```bash
./bin/wp-agency new <slug> --from wp-zip --zip /path/to/dump.zip
```

The CLI copies `wp-content/themes` and `plugins` when it finds them. Sort leftovers in `_incoming/wp-zip`.

## Then

1. Place `uploads` into the running volume or bind if you add one.
2. Import `.sql` into the project MariaDB (phpMyAdmin on PMA_PORT or `mariadb` in the db container).
3. WP-CLI `search-replace` live URL → `http://localhost:<WP_PORT>` (backup first).
4. `theme activate` the client theme.

## Sibling PHP apps

If the dump also contains a POS/billing PHP app:

- Do **not** put it under `wp-content/`
- Own folder + own database
- Skill **hostinger-mcp-deploy** for Hostinger production

## Verify

WP homepage 200 locally; wp-admin login; no mixed live URLs in options.
