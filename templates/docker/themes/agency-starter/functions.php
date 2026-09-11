<?php
/**
 * Agency Starter — enqueue only. Replace with a real client theme.
 */
function agency_starter_setup() {
    add_theme_support('title-tag');
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'agency-starter'),
    ));
}
add_action('after_setup_theme', 'agency_starter_setup');

function agency_starter_assets() {
    wp_enqueue_style(
        'agency-starter',
        get_stylesheet_uri(),
        array(),
        wp_get_theme()->get('Version')
    );
}
add_action('wp_enqueue_scripts', 'agency_starter_assets');
