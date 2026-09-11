# Hostinger file upload (TUS) and permissions

## Upload URL API (concept)

Hostinger Hosting Files API can generate an upload URL with auth keys for TUS 1.0.0 resumable upload into the website file storage (typically under `public_html`).

Flow (when MCP exposes the matching tools):

1. Call generate upload URL for the target hosting website/username
2. Receive `url`, `auth_key`, `rest_auth_key`
3. `POST` to create the upload (headers: `Tus-Resumable`, `Upload-Length`, `X-Auth`, `X-Auth-Rest`)
4. `PATCH` file bytes until complete
5. Extract the zip on the server (File Manager, MCP extract if available, or SSH `unzip`)

`relative_file_path` is relative to `public_html` (e.g. `ebill-deploy.zip` or `ebill/app.zip`).

Prefer MCP tool names discovered via `search_tool` over hard-coding — Hostinger regenerates tool catalogs from OpenAPI.

## Packaging tips

Exclude from deploy zips:

- `*.DS_Store`
- Local test PDFs under `bills/` (keep `.htaccess`)
- `scratch/`, nested duplicate trees, large vendor zips already extracted
- SQL dumps next to the public tree
- Local-only Docker or seed junk

## Permissions

On shared hosting, typical needs:

| Path | Mode (typical) | Why |
|---|---|---|
| App PHP dirs | `755` / files `644` | Serve code |
| `bills/`, `uploads/` | writable by PHP (`775` or host default) | Generated PDFs / QR uploads |
| `config/db.php` | not world-writable | Secrets |

After upload, verify:

- App URL returns login (not WP 404)
- Direct listing of private dirs fails
- WordPress still serves `/`

## Fallback without TUS MCP

1. Build zip locally
2. hPanel → File Manager → upload → extract into target folder
3. Still use MCP for DB create / PHP / cache when possible

## Extract rules (critical)

- Destination must be `public_html/<app>/`, never bare `public_html/`
- Confirm `<app>` is a **directory**, not a 0-byte file
- If someone unzips into WP root by mistake, follow recovery in `production-lessons.md`
