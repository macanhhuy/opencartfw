/*
Theme Name: Sellegance
Version: 1.4.4.1
*/

$(document).ready(function(){

	/* ---------------------------------------------------------------------- */
	/*	Forms Validation
	/* ---------------------------------------------------------------------- */

		jQuery.validator.setDefaults({
			errorClass: "error",
			validClass: "success",
			errorElement: "span",
			highlight: function(element, errorClass, validClass) {
				if (element.type === 'radio') {
					this.findByName(element.name).parent("div").parent("div").removeClass(validClass).addClass(errorClass);
				} else { $(element).parent("div").parent("div").removeClass(validClass).addClass(errorClass);	}
			},
			unhighlight: function(element, errorClass, validClass) {
				if (element.type === 'radio') { this.findByName(element.name).parent("div").parent("div").removeClass(errorClass).addClass(validClass);
				} else { $(element).parent("div").parent("div").removeClass(errorClass).addClass(validClass);	}
			},
			errorPlacement: function(error, element) {
				error.insertAfter(element);
			}
		});

		$("#contact-form").validate({
			rules: {
				enquiry: {
					required: true,
					minlength: 10
				}
			}
		});

		$("#register-form, #password-form").validate({
			rules: {
				password: {
					required: true, minlength: 3
				},
				confirm: {
					required: function(element) {
						var str = $("#password").val();

						return str.length > 0;
					},
					equalTo: "#password",
					minlength: 3
				}
			}
		});

		$("#edit-account, #voucher, #address, #return, #login, #forgotten").validate();

	/* ---------------------------------------------------------------------- */
	/*	Search
	/* ---------------------------------------------------------------------- */

		$('.button-search').bind('click', function() {
			url = $('base').attr('href') + 'index.php?route=product/search';

			var filter_name = $('input[name=\'filter_name\']').attr('value');

			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}

			location = url;
		});

		$('#header input[name=\'filter_name\']').bind('keydown', function(e) {
			if (e.keyCode == 13) {
				url = $('base').attr('href') + 'index.php?route=product/search';

				var filter_name = $('input[name=\'filter_name\']').attr('value');

				if (filter_name) {
					url += '&filter_name=' + encodeURIComponent(filter_name);
				}

				location = url;
			}
		});

	/* ---------------------------------------------------------------------- */
	/*	Opacity animation on hover
	/* ---------------------------------------------------------------------- */

		if ($.browser.msie && ($.browser.version == 8 || $.browser.version == 7 || $.browser.version == 6)) {

		} else {

			$(".image-additional > a").hover(function() {
				$(this).siblings().stop().animate({ opacity: .85 }, 500)}, function () {
					$(this).siblings().stop().animate({ opacity: 1 }, 300) }
			);

			$("#toggle_sidebar").hover(function() {
				$(".sidebar").stop().animate({ opacity: .55 }, 300)}, function () {
					$(".sidebar").stop().animate({ opacity: 1 }, 300)}
			);
		}


	/* ---------------------------------------------------------------------- */
	/*	Ajax Minicart
	/* ---------------------------------------------------------------------- */

		$("#cart > .heading a").live('mouseover', function () {

			$('#cart').addClass('active');

			$('#cart').load('index.php?route=module/cart #cart > *');

			$('#cart').live('mouseleave', function() {
				$(this).removeClass('active');
			});

		});


	/* ---------------------------------------------------------------------- */
	/*	Language/Currency dropdowns
	/* ---------------------------------------------------------------------- */

		$('.dropd').click(function() {

			$(this).find('.options').slideDown('fast');
			$(this).addClass('active');

			$(this).bind('mouseleave', function() {
				$(this).find('.options').slideUp('fast');
				$(this).removeClass('active');
			});

		});

	/* ---------------------------------------------------------------------- */
	/*	Footer menu
	/* ---------------------------------------------------------------------- */

		$(".column .header").click(function () {

			$screensize = $(window).width();

			if ($screensize < 767) {
				$(this).toggleClass("active");
				$(this).parent().find(".content").slideToggle('medium');
			}

		});


	/* ---------------------------------------------------------------------- */
	/*	Scroll to top
	/* ---------------------------------------------------------------------- */

		$().UItoTop({
			easingType: 'easeOutQuart',
			scrollSpeed: 1200
		});


	/* ---------------------------------------------------------------------- */
	/*	Toggle sidebar
	/* ---------------------------------------------------------------------- */

		$("#toggle_sidebar").click(function () {

			$(this).toggleClass("collapse");

			$(".sidebar").toggleClass("close");

			if ($("#maincontent").hasClass("middle")) {
				$("#maincontent").toggleClass('span6 span12');
			} else {
				$("#maincontent").toggleClass('span9 span12');
			}

		});

	/* ---------------------------------------------------------------------- */
	/*	Tooltips
	/* ---------------------------------------------------------------------- */

		$('.tooltp').tooltip();


	/* ---------------------------------------------------------------------- */
	/*	Mobile menu
	/* ---------------------------------------------------------------------- */
		$('#mobileMenu').change(function(){
			if($(this).val() !== null){document.location.href = $(this).val()}
		});


	/* ---------------------------------------------------------------------- */
	/*	Colorbox
	/* ---------------------------------------------------------------------- */

		$('.colorbox').colorbox({
			overlayClose: true,
			opacity: 0.5,
			maxHeight: 560,
			maxWidth: 560,
			width:'100%'
		});

		// In case you want to change the colorbox popup only for the product images.

		$('.colorbox-product').colorbox({
			overlayClose: true,
			opacity: 0.5,
			maxHeight: 760,
			maxWidth: 760,
			width:'100%'
		});

	/* ---------------------------------------------------------------------- */
	/*	Accordion
	/* ---------------------------------------------------------------------- */

		$('.accordion-group:first-child .accordion-toggle').addClass('active');

	    $('.accordion').on('show', function (e) {
	         $(e.target).prev('.accordion-heading').find('.accordion-toggle').addClass('active');
	    });

	    $('.accordion').on('hide', function (e) {
	        $(this).find('.accordion-toggle').not($(e.target)).removeClass('active');
	    });

	/* ---------------------------------------------------------------------- */
	/*	Tabs
	/* ---------------------------------------------------------------------- */

		$('#tabs a').tabs();


	/* ---------------------------------------------------------------------- */
	/*	Banners
	/* ---------------------------------------------------------------------- */

		var banner = function() {
			$('.banner').cycle({
				before: function(current, next) {
					$(next).parent().height($(next).outerHeight());
				}
			});
		}

		setTimeout(banner, 2000);

	/* ---------------------------------------------------------------------- */
	/*	Alert boxes
	/* ---------------------------------------------------------------------- */

		$('.success img, .warning img, .attention img, .information img').live('click', function() {
			$(this).parent().fadeOut('slow', function() {
				$(this).remove();
			});
		});

});


	/* ---------------------------------------------------------------------- */
	/*	Same height for all grid boxes
	/* ---------------------------------------------------------------------- */

		// Adjust boxes height when the page is completely loaded
		$(window).load(function(){
			doAdjust = true;
			previousWidth = 0;
			adjustBoxHeights();

		});

		// Raise doAdjust flag every time the window width changes

		$(window).resize(function() {
			var currentWidth = $(window).width();
			if (previousWidth != currentWidth) {
				doAdjust = true;
			}
			previousWidth = currentWidth;
		})

		// Run every half second

		$(function() {
			setInterval('maybeAdjust()', 500);
		});

		// Check the doAdjust flag

		function maybeAdjust() {
			if (doAdjust) {
				adjustBoxHeights();
				doAdjust = false;
			}
		}

		// Loop through the DIVs and find the height of the tallest one, then loop again and set them all to that height

		function adjustBoxHeights() {
			var maxHeight = 0;
			$('.product-grid > div, .content-top .product-box > div, .content-bottom .product-box > div').each(function(){
				$(this).height('auto');
				if (maxHeight < $(this).height()) {maxHeight = $(this).height()}
			});
			$('.product-grid > div, .content-top .product-box > div, .content-bottom .product-box > div').each(function(){
				$(this).height(maxHeight);
			});
		}


	function getURLVar(urlVarName) {
		var urlHalves = String(document.location).toLowerCase().split('?');
		var urlVarValue = '';

		if (urlHalves[1]) {
			var urlVars = urlHalves[1].split('&');

			for (var i = 0; i <= (urlVars.length); i++) {
				if (urlVars[i]) {
					var urlVarPair = urlVars[i].split('=');

					if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
						urlVarValue = urlVarPair[1];
					}
				}
			}
		}

		return urlVarValue;
	}

	/* ---------------------------------------------------------------------- */
	/*	Add to Cart
	/* ---------------------------------------------------------------------- */

		function addToCart(product_id, quantity) {
			quantity = typeof(quantity) != 'undefined' ? quantity : 1;

			$.ajax({
				url: 'index.php?route=checkout/cart/add',
				type: 'post',
				data: 'product_id=' + product_id + '&quantity=' + quantity,
				dataType: 'json',
				success: function(json) {
					$('.success, .warning, .attention, .information, .error').remove();

					if (json['redirect']) {
						location = json['redirect'];
					}

					if (json['success']) {

						$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/sellegance/images/close.png" alt="" class="close" /></div>');

						$('.success').fadeIn('slow');

						$('html, body').animate({ scrollTop: 0 }, 'slow');

						/*$.colorbox({
							html:'<p class="success_message" style="margin:20px 10px 10px; text-align:center;">' + json['success'] + '</p><div class="buttons"><a href="#"><span class="button button-mini">Continue shopping</span></a> <a href="index.php?route=checkout/cart"><span class="button button-mini button-cart">Shopping Cart</span></a> </div>',overlayClose: true,
							opacity: 0.5,
							maxHeight: 560,
							maxWidth: 560,
							width:'100%'
						});*/

						$('#cart-total').html(json['total']);

					}
				}
			});
		}

	/* ---------------------------------------------------------------------- */
	/*	Add to Wishlist
	/* ---------------------------------------------------------------------- */

		function addToWishList(product_id) {
			$.ajax({
				url: 'index.php?route=account/wishlist/add',
				type: 'post',
				data: 'product_id=' + product_id,
				dataType: 'json',
				success: function(json) {
					$('.success, .warning, .attention, .information').remove();

					if (json['success']) {
						$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/sellegance/images/close.png" alt="" class="close" /></div>');

						$('.success').fadeIn('slow');

						$('#wishlist-total').html(json['total']);

						$('html, body').animate({ scrollTop: 0 }, 'slow');
					}
				}
			});
		}

	/* ---------------------------------------------------------------------- */
	/*	Add to Compare
	/* ---------------------------------------------------------------------- */

		function addToCompare(product_id) {
			$.ajax({
				url: 'index.php?route=product/compare/add',
				type: 'post',
				data: 'product_id=' + product_id,
				dataType: 'json',
				success: function(json) {
					$('.success, .warning, .attention, .information').remove();

					if (json['success']) {
						$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/sellegance/images/close.png" alt="" class="close" /></div>');

						$('.success').fadeIn('slow');

						$('#compare-total').html(json['total']);

						$('html, body').animate({ scrollTop: 0 }, 'slow');
					}
				}
			});
		}

	/* ---------------------------------------------------------------------- */
	/*	jquery.cookie.js Apache mod_security blocks the file in some servers.
	/* ---------------------------------------------------------------------- */

		/**
		 * jQuery Cookie plugin
		 *
		 * Copyright (c) 2010 Klaus Hartl (stilbuero.de)
		 * Dual licensed under the MIT and GPL licenses:
		 * http://www.opensource.org/licenses/mit-license.php
		 * http://www.gnu.org/licenses/gpl.html
		 *
		 */

		jQuery.cookie = function (key, value, options) {

		    // key and value given, set cookie...
		    if (arguments.length > 1 && (value === null || typeof value !== "object")) {
		        options = jQuery.extend({}, options);

		        if (value === null) {
		            options.expires = -1;
		        }

		        if (typeof options.expires === 'number') {
		            var days = options.expires, t = options.expires = new Date();
		            t.setDate(t.getDate() + days);
		        }

		        return (document.cookie = [
		            encodeURIComponent(key), '=',
		            options.raw ? String(value) : encodeURIComponent(String(value)),
		            options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
		            options.path ? '; path=' + options.path : '',
		            options.domain ? '; domain=' + options.domain : '',
		            options.secure ? '; secure' : ''
		        ].join(''));
		    }

		    // key and possibly options given, get cookie...
		    options = value || {};
		    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
		    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
		};

	/* ---------------------------------------------------------------------- */
	/*	Grid/List view
	/* ---------------------------------------------------------------------- */

		function display(view) {

			if (view == 'list') {

				$('#list').addClass('active');
				$('#grid').removeClass('active');

				$('.product-grid').toggleClass('product-grid product-list');

				$('.product-list > div').each(function(index, element) {

					$(this).removeClass('alpha alpha3 alpha4 alpha5 odd grid-box');

					$(this).addClass('product-row');
					$(this).height('auto');

					var special = $(element).find('.onsale').html();

					if (special != null) {
						html = '<span class="onsale">' + special  + '</span>';
						html += '<div class="row-fluid">';
					} else {
						html = '<div class="row-fluid">';
					}

					var image = $(element).find('.image').html();

					if (image != null) {
						html += '<div class="image span3">' + image + '</div>';
					} else {
						html += '<div class="image span3">&nbsp;</div>';
					}

					html += '<div class="name-desc span4">';

					html += '<div class="name">' + $(element).find('.name').html() + '</div>';
					var rating = $(element).find('.rating').html();

					if (rating != null) {
						html += '<div class="rating">' + rating + '</div>';
					}
					html += '<div class="description">' + $(element).find('.description').html() + '</div>';

					html += '</div>';

					var price = $(element).find('.price').html();

					if (price != null) {
						html += '<div class="price span2">' + price  + '</div>';
					} else {
						html += '<div class="price span2">&nbsp;</div>';
					}

					html += '<div class="actions span3">';
					html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';

					var wishlist = $(element).find('.wishlist').html();
					if (wishlist != null) {
						html += '  <div class="wishlist">' + wishlist + '</div>';
					}

					var compare = $(element).find('.compare').html();
					if (compare != null) {
						html += '  <div class="compare">' + compare + '</div>';
					}

					html += '</div>';

					html += '</div>';


					$(element).html(html);
				});

				$.cookie('display', 'list');

			} else {

				$('#grid').addClass('active');
				$('#list').removeClass('active');

				$('.product-list').toggleClass('product-list product-grid');

				$('.product-grid > div').each(function(index, element) {

					$(this).addClass('grid-box');

					html = '';

					var image = $(element).find('.image').html();

					html += '<div class="inner">';

					var special = $(element).find('.onsale').html();

					if (special != null) {
						html += '<span class="onsale">' + special  + '</span>';
					}

					if (image != null) {
						html += '<div class="image">' + image + '</div>';
					}

					html += '<div class="name">' + $(element).find('.name').html() + '</div>';

					html += '<div class="description">' + $(element).find('.description').html() + '</div>';

					var price = $(element).find('.price').html();

					if (price != null) {
						html += '<div class="price">' + price  + '</div>';
					}

					html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';

					var rating = $(element).find('.rating').html();

					if (rating != null) {
						html += '<div class="rating">' + rating + '</div>';
					}

					var wishlist = $(element).find('.wishlist').html();
					if (wishlist != null) {
						html += '  <div class="wishlist">' + wishlist + '</div>';
					}

					var compare = $(element).find('.compare').html();
					if (compare != null) {
						html += '  <div class="compare">' + compare + '</div>';
					}

					html += '</div>';

					$(element).html(html);

				});

				$.cookie('display', 'grid');

				adjustBoxHeights();

			}

			$('.tooltp').tooltip();

		}

		view = $.cookie('display');

		if (view=='list') {	display(view);	}



	/* ---------------------------------------------------------------------- */
	/*	Responsive video embeds
	/* ---------------------------------------------------------------------- */

		/*!
		* FitVids 1.0
		*
		* Copyright 2011, Chris Coyier - http://css-tricks.com + Dave Rupert - http://daverupert.com
		* Credit to Thierry Koblentz - http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/
		* Released under the WTFPL license - http://sam.zoy.org/wtfpl/
		*
		*/

		(function( $ ){

		  $.fn.fitVids = function( options ) {
		    var settings = {
		      customSelector: null
		    }

		    if ( options ) {
		      $.extend( settings, options );
		    }

		    return this.each(function(){
		      var selectors = [
		        "iframe[src*='player.vimeo.com']",
		        "iframe[src*='www.youtube.com']",
		        "iframe[src*='www.kickstarter.com']",
		        "object",
		        "embed"
		      ];

		      if (settings.customSelector) {
		        selectors.push(settings.customSelector);
		      }

		      var $allVideos = $(this).find(selectors.join(','));

		      $allVideos.each(function(){
		        var $this = $(this);
		        if (this.tagName.toLowerCase() == 'embed' && $this.parent('object').length || $this.parent('.fluid-width-video-wrapper').length) { return; }
		        var height = ( this.tagName.toLowerCase() == 'object' || $this.attr('height') ) ? $this.attr('height') : $this.height(),
		            width = $this.attr('width') ? $this.attr('width') : $this.width(),
		            aspectRatio = height / width;
		        if(!$this.attr('id')){
		          var videoID = 'fitvid' + Math.floor(Math.random()*999999);
		          $this.attr('id', videoID);
		        }
		        $this.wrap('<div class="fluid-width-video-wrapper"></div>').parent('.fluid-width-video-wrapper').css('padding-top', (aspectRatio * 100)+"%");
		        $this.removeAttr('height').removeAttr('width');
		      });
		    });
		  }
		})( jQuery );

		$(".container").fitVids();