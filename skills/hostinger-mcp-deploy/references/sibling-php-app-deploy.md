# Sibling PHP app next to WordPress (Hostinger)

## Pattern

```text
Hostinger shared hosting (same account)
├── public_html/                 ← WordPress (unchanged)
│   ├── wp-admin/
│   ├── wp-content/
│   └── …
└── sibling app
    ├── public_html/ebill/       ← subfolder URL: /ebill/
    └── or subdomain docroot     ← e.g. billing.example.com
```

The sibling app:

- Is classic PHP + its **own** MySQL database
- Shares the hosting account / SSL (subfolder) or uses subdomain SSL
- Is **staff-facing** or private — do not put it in the public WP menu unless intentional

## Do not

- Install the app as a WordPress plugin
- Drop files under `wp-content/themes` or `wp-content/plugins`
- Point the sibling app at the WordPress database
- Run `hosting_importWordpressWebsite` with a non-WP zip

## Subfolder vs subdomain

| | Subfolder `/app/` | Subdomain `app.` |
|---|---|---|
| Setup | Create folder under `public_html` | Create subdomain + folder |
| SSL | Usually inherits main domain | Wait for AutoSSL |
| Isolation | Weaker (same cookie/path surface) | Cleaner for staff-only |
| Speed to live | Faster | Slightly more DNS/SSL wait |

## Go-live checklist (sibling PHP)

- [ ] Own DB created; credentials only on server / secret store
- [ ] PHP version + extensions verified
- [ ] Writable dirs limited and intentional
- [ ] Private storage denied via `.htaccess` (or equivalent)
- [ ] Migrate/seed not publicly callable from the web
- [ ] Strong admin password (no local demo passwords)
- [ ] WordPress homepage smoke-tested after upload
- [ ] Hostinger cache cleared

## Local Docker note (agency)

Client projects may run WordPress and a sibling PHP app in one Compose stack (extra service + port). Local billing ports are **not** the WP_PORT allocation grid in agency `CLAUDE.md` — document sibling ports in the client `CLAUDE.md` / `Claude.md`.
