<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet-responsive.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/bootstrap.min.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/responsive.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/custom.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/jquery.ui.totop.js"></script>
<script type="text/javascript" src="catalog/view/theme/default/js/cloud-zoom.1.0.3-min.js"></script><?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php if ($stores) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body>
<div id="container">
<header id="header" class="container">
  <div class="row-fluid">
  <div class="span4">
  <?php if ($logo) { ?>
  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
  <?php } ?>
  </div>
  <div class="span4" style="position: relative;">
      <div id="welcome">
    <?php if (!$logged) { ?>
    <?php echo $text_welcome; ?>
    <?php } else { ?>
    <?php echo $text_logged; ?>
    <?php } ?>
  </div>
  <?php echo $language; ?>
  <?php //echo $currency; ?>
    <div id="search">
    <div class="button-search"></div>
    <input type="text"  class="span12" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
  </div>

  </div>

  <div class="span4">
<?php echo $cart; ?>
  </div>
  </div>
  <div class="row-fluid">

  <div class="links pull-right">
<<<<<<< HEAD
    <a href="<?php echo $home; ?>" class="hidden-desktop" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<?php echo $text_home; ?>"><i class="icon-home"></i></a>
=======
    <a href="<?php echo $home; ?>" class="visible-phone hidden-desktop" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<?php echo $text_home; ?>"><i class="icon-home"></i></a>
>>>>>>> c6da355cf9bda2873bfc35d6768ca406fc81fb1b
    <a href="<?php echo $home; ?>" class="hidden-phone"><?php echo $text_home; ?></a><a href="<?php echo $wishlist; ?>" id="wishlist-total" class="hidden-phone"><?php echo $text_wishlist; ?></a><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></div>
  </div>

</header>
<?php if ($categories) { ?>
<nav id="menu" class="container">
 <div class="navbar">
  <div class="navbar-inner">
    <div class="container" style="width: auto;">
      <button class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse" title="" rel="tooltip" data-placement="left" data-original-title="Menu">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <div class="nav-collapse">
          <ul class="nav">
    <?php $i=0; foreach ($categories as $category) { ?>

      <?php if ($category['children']) { ?>
      <li class="dropdown">
            <a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?><b class="caret"></b></a>
             <?php if($i==0){
              echo '<ul class="dropdown-menu pull-left">';
            }
            else {
              echo '<ul class="dropdown-menu pull-right">';
            }
            ?>

        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <div>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($category['children'][$i])) { ?>
          <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>

      </div>
        <?php } ?>
         </ul>
       <?php }
      else {
        ?>
        <li>
            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
        <?php
      } ?>
    </li>
    <?php $i++; } ?>
  </ul>
      </div><!-- /.nav-collapse -->
    </div>
  </div><!-- /navbar-inner -->

</nav>
<?php } ?>
<section id="wrap-content" class="container">
<div id="notification"></div>
<div class="row-fluid">
