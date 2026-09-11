# Safety and secrets (Hostinger MCP)

## Secrets

| Secret | Where it may live | Never |
|---|---|---|
| Hostinger OAuth tokens | Grok `~/.grok/mcp_credentials.json`; Hostinger MCP credential store | Git, chat paste, screenshots |
| `HOSTINGER_API_TOKEN` | Environment variable / editor secret storage | Committed TOML/JSON |
| Live DB password | Server `config/db.php` or host env | Client repo commits |
| Staff POS passwords | Password manager; force-change on first login | `Admin@…` demo passwords on production |

If a token was pasted into a config file: rotate it in hPanel → API, remove from disk, prefer OAuth.

## Blast-radius checklist before writes

1. Domain matches the client (e.g. `balloonsunlimitedarunachal.com`)
2. Hosting username matches that site
3. Target path is the sibling folder or subdomain — **not** `wp-content`
4. Database name is new or intentionally reused (fresh vs import strategy agreed)
5. User confirmed overwrite if files already exist at the path

## Rate limits

Hostinger API: about **90 requests/minute** per user. Pace bulk file ops; back off on `429`.

## Dangerous tools

Treat as high-risk; confirm explicitly:

- Delete database
- Delete website / subdomain
- WordPress import (overwrites site files)
- Mass DNS changes

## After go-live

- Remove temporary public migrate/debug scripts
- Confirm `robots.txt` / noindex for staff apps if required
- Clear Hostinger cache
- Hand credentials via a secure channel, not git
