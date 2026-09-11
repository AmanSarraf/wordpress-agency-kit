---
name: hostinger-mcp-deploy
description: "Use when connecting Hostinger MCP to Grok, Claude Code, or Cursor; deploying WordPress or a sibling PHP app (POS, billing, CRM, custom PHP) onto Hostinger shared hosting; creating Hostinger MySQL databases or subdomains; uploading via Hostinger TUS/file APIs; recovering from a bad unzip into public_html; resetting bcrypt admin passwords via phpMyAdmin; or writing a client handover for a Hostinger go-live. Prefer this over inventing FTP-only steps when Hostinger MCP or API access is available."
compatibility: "Grok, Claude Code, Cursor. Official @hostinger/mcp / Hostinger Connector. Node 20+ for local stdio MCP."
---

# Hostinger MCP Deploy (agency + reusable)

Generic skill for **any** client on Hostinger: WordPress sites and **sibling PHP apps** that sit next to WordPress (not as plugins).

## When to use

- Wire Hostinger MCP into an AI coding agent
- Create DB / upload / go-live on Hostinger shared hosting
- Deploy a non-WordPress PHP+MySQL app under `/app/` or a subdomain
- Fix extract/unzip mistakes that flooded `public_html`
- Document emergency admin reset + client handover

## Hard rules

1. Sibling PHP apps are **not** WordPress plugins — never under `wp-content/`.
2. Never use `hosting_importWordpressWebsite` for non-WP zips.
3. Prefer OAuth (`npx @hostinger/mcp --login` or remote MCP) over committing API tokens.
4. Read-only discovery (list websites/DBs/files) before any create/upload/delete.
5. Never commit live DB passwords, production `db.php`, or handover TXT into git.

## Procedure

### 0) Connect MCP

Preferred (reliable in practice):

```bash
npx -y @hostinger/mcp --login
grok mcp add hostinger --scope user -- npx -y @hostinger/mcp
grok mcp doctor hostinger
```

Details: `references/grok-and-claude-wiring.md`

### 1) Choose shape

| Shape | URL | Docroot |
|---|---|---|
| Subfolder | `https://example.com/app/` | `public_html/app/` |
| Subdomain | `https://app.example.com` | subdomain folder |

Sibling apps get their **own** MySQL database.  
Read: `references/sibling-php-app-deploy.md`

### 2) Provision

1. List websites → note hosting **username** + domain  
2. Create MySQL DB + user (strong password; store outside git)  
3. Confirm PHP 8.1+ and needed extensions  
4. Create subdomain only if that URL shape was chosen  

### 3) Package + upload

1. Clean zip (no test PDFs, dumps, `.DS_Store`, nested junk)  
2. Upload via Hostinger upload-url (TUS) or File Manager  
3. **Extract into the app folder only** — never unzip into `public_html` root beside `wp-admin`  
4. Confirm target is a **folder**, not a 0-byte file with the same name  

Read: `references/tus-upload-and-permissions.md`  
Production pitfalls: `references/production-lessons.md`

### 4) Configure, migrate, seed

1. Production DB config on server (untracked secrets)  
2. Schema via SSH `php migrate.php`, remote MySQL import, or phpMyAdmin — not a public web migrate  
3. Seed admin with strong password + `must_change_password` when supported  
4. Smoke: app login, WP homepage still OK, critical write path, private dirs denied  

### 5) Handover

Use `templates/CLIENT-HANDOVER-TEMPLATE.txt` — fill live URL, admin, DB, emergency reset.  
Give privately; tell client to rotate passwords after receipt.

## Safety

`references/safety-and-secrets.md`

Before deletes/overwrites: restate domain, username, path; confirm if ambiguous.

## Escalation

- Upload/extract flaky via API → File Manager; still use API for DB create when possible  
- No SSH → schema SQL + phpMyAdmin / temporary remote MySQL from developer IP  
- WP-CLI content ops → `wp-wpcli-and-ops` (needs `wp` on the environment)  
