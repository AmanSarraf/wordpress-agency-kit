<?php get_header(); ?>
<main class="site">
  <?php if (have_posts()) : while (have_posts()) : the_post(); ?>
    <article <?php post_class(); ?>>
      <h1><?php the_title(); ?></h1>
      <?php the_content(); ?>
    </article>
  <?php endwhile; else : ?>
    <h1><?php bloginfo('name'); ?></h1>
    <p>Agency Starter is active. Add a client theme under <code>themes/</code> or import an HTML template.</p>
  <?php endif; ?>
</main>
<?php get_footer(); ?>
