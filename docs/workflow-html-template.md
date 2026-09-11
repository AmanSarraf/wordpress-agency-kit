# Workflow: HTML/CSS zip → WordPress theme

1. `./bin/wp-agency doctor`
2. `./bin/wp-agency new client-slug --from html --zip ~/Downloads/template.zip`
3. `cd ../client-projects/client-slug && docker compose up -d`
4. Ask your agent to convert `html-template/` into `themes/<slug>/` using skill **html-to-classic-theme**
5. Activate the theme via WP admin or WP-CLI inside the wordpress container
