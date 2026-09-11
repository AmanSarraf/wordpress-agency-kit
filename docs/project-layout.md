# Project layout

```text
~/Developer/
  wordpress-agency-kit/     ← clone of this product
  client-projects/
    acme-bakery/
      CLAUDE.md
      docker-compose.yml
      .env
      themes/
      plugins/
      html-template/
```

Set `WP_AGENCY_CLIENTS_DIR` if you keep clients elsewhere.

`./bin/wp-agency ports` shows WP / phpMyAdmin ports so two clients can run at once.
