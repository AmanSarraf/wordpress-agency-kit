---
name: html-to-classic-theme
description: "Use when converting an HTML/CSS/Bootstrap/ThemeForest template into a classic PHP WordPress theme: unzip to html-template/, copy assets, enqueue, wp_nav_menu, front-page.php sections, CPT plugin for editable content. Not for FSE/block themes unless the user explicitly wants blocks."
---

# HTML / CSS template → classic WordPress theme

## Layout

Keep `html-template/` as **read-only reference**. Build:

```text
themes/<client-theme>/
  style.css          Theme header + CSS variables for brand
  functions.php      after_setup_theme + wp_enqueue_scripts only
  index.php          fallback loop
  front-page.php     homepage sections
  page.php
  header.php         wp_head(); wp_nav_menu()
  footer.php         wp_footer()
  assets/            css/, js/, vendor/, img/ copied from html-template
```

## Rules

- Enqueue **all** CSS/JS — never raw `<link>` / `<script>` in templates
- `wp_nav_menu()` — never hardcode nav `<ul>` items
- `get_template_directory_uri()` for asset URLs
- Homepage content from `WP_Query` + CPTs (`<slug>-cpt` plugin), not hardcoded PHP arrays
- After seeding, delete `seeder.php`

## CPT plugin

`plugins/<slug>-cpt/<slug>-cpt.php`: `register_post_type`, `register_post_meta` (`show_in_rest`), meta boxes, `save_post` with nonce + capability + sanitization.

## Verify

Local `http://localhost:<WP_PORT>` homepage matches template sections; menus editable in WP admin; assets 200.
