# Wiring Hostinger MCP (Grok / Claude / Cursor)

Official docs: https://docs.hostinger.com/hostinger-connector/manual-configuration  
Hosted endpoint: `https://mcp.hostinger.com`  
CLI package: `@hostinger/mcp`

## Recommended: local stdio + CLI login (Grok)

Remote `https://mcp.hostinger.com` works, but in-TUI Auth can be confusing. This path worked reliably:

```bash
# 1) One-time browser login — stores creds in ~/.config/hostinger-mcp/
npx -y @hostinger/mcp --login

# 2) Point Grok at local MCP (uses those creds)
grok mcp remove hostinger --scope user 2>/dev/null
grok mcp add hostinger --scope user -- npx -y @hostinger/mcp

# 3) Verify
grok mcp doctor hostinger   # expect handshake OK + hundreds of tools
```

`~/.grok/config.toml` equivalent:

```toml
[mcp_servers.hostinger]
command = "npx"
args = ["-y", "@hostinger/mcp"]
enabled = true
```

After adding: `/mcps` → `r` refresh, or new session, so `search_tool` / `use_tool` see Hostinger.

Credentials: `~/.config/hostinger-mcp/credentials.json` (`0600`). Prefer full-disk encryption.

### API token instead of OAuth

hPanel → Profile → API → generate token. Pass via env only:

```toml
[mcp_servers.hostinger]
command = "npx"
args = ["-y", "@hostinger/mcp"]
env = { HOSTINGER_API_TOKEN = "${HOSTINGER_API_TOKEN}" }
enabled = true
```

Never commit the token.

## Alternative: remote HTTP MCP

```bash
grok mcp add --transport http hostinger https://mcp.hostinger.com --scope user
```

Then `/mcps` → select hostinger → **`i`** Auth. If AuthRequired persists, use CLI `--login` + stdio above.

## Claude Code

```bash
claude mcp add --transport http hostinger https://mcp.hostinger.com
# or local:
claude mcp add hostinger -- npx -y @hostinger/mcp
```

## Cursor

Hostinger Connector extension (managed OAuth), or the same JSON `url` / `npx @hostinger/mcp` forms.

## Narrow tool surface (optional)

| Binary | Scope |
|---|---|
| `hostinger-hosting-mcp` | Websites, DB, files, PHP, cron |
| `hostinger-wordpress-mcp` | WP install/plugins/themes/cache |
| `hostinger-dns-mcp` | DNS records |

```toml
[mcp_servers.hostinger-hosting]
command = "npx"
args = ["-y", "--package=@hostinger/mcp", "hostinger-hosting-mcp"]
enabled = true
```

## Loading this skill in Grok from any project

If Claude skill auto-scan is off, add an explicit path:

```toml
[skills]
paths = ["/ABS/PATH/TO/wordpress-agency/.claude/skills"]
```

Or copy/symlink `hostinger-mcp-deploy/` into `~/.grok/skills/`.
