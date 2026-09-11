# Workflow: WordPress / Hostinger dump zip

1. `./bin/wp-agency doctor`
2. `./bin/wp-agency new client-slug --from wp-zip --zip ~/Downloads/public_html.zip`
3. Import SQL if the dump includes one (phpMyAdmin on PMA_PORT)
4. Skill **wp-zip-import**: search-replace URLs, activate theme
5. Sibling PHP POS/billing: skill **hostinger-mcp-deploy** — not a WP plugin
