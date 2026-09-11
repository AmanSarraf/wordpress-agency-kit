# Production lessons (Hostinger shared hosting)

Generic failures seen across sibling-PHP deploys. Apply to any client.

## 1) Folder vs file with the same name

Creating `public_html/app` via some File Browser POSTs can create a **0-byte file**, not a directory.

Symptom: `https://example.com/app/login.php` → 404 even though “app” appears in File Manager.

Fix:

1. Delete the file named `app` (confirm `isDir=false`, size 0)
2. Create a real **directory** `app`
3. Extract/upload into that directory

## 2) Never unzip into `public_html` root

Extracting a sibling app zip beside `wp-admin` / `wp-content`:

- Overwrites WordPress `index.php` with the app’s large `index.php`
- Drops `login.php`, `actions/`, `config/`, etc. into the WP root

Recovery:

1. Classify top-level names: WP keep-list vs app zip top-level
2. **Move** app files into `public_html/app/`
3. Restore WordPress `index.php` (canonical stub loading `wp-blog-header.php`)
4. Restore `.htaccess` from `.htaccess.bk` if present
5. Smoke WP homepage + app login URL

WP keep examples: `wp-admin`, `wp-content`, `wp-includes`, `wp-*.php`, `xmlrpc.php`, `license.txt`, `readme.html`

## 3) Extract destination checklist

Before Extract in File Manager:

- [ ] Target folder exists and is a **directory**
- [ ] Destination path is `public_html/<app>/` not `public_html/`
- [ ] Zip size looks right (not 0 bytes after a bad move)

## 4) Schema without SSH

Options:

- Temporary remote MySQL allowlist for developer IP → import schema from local Docker/client → **remove** remote rule
- phpMyAdmin import of schema SQL
- hPanel Terminal / SSH: `php migrate.php` (CLI-only migrate preferred)

## 5) Emergency bcrypt admin reset (phpMyAdmin)

```sql
UPDATE users
SET password = '$2y$10$PASTE_HASH',
    must_change_password = 1,
    is_active = 1,
    role = 'admin'
WHERE username = 'admin';
```

Generate hash with PHP `password_hash($plain, PASSWORD_BCRYPT)`.  
Wrong DB = WordPress DB — always use the sibling app database.

## 6) Secrets

| Keep | Do not |
|---|---|
| Untracked `.prod-*.env` / handover TXT offline | Commit passwords to git |
| Rotate after handover | Leave demo passwords on production |
| Own DB for sibling app | Point app at WordPress DB |
