var params = {

	//Some dynamic text can be modified here
	texts: {
		emailstatus: 'Enter your email to subscribe',
		emailinvalid: 'Oops, it seems your email address is not valid!',
		emailok: 'Ok, your email looks fine, click submit!',
		emailwait: 'Please wait...',
		emailadded: "Thanks, we got you! we will email you on launch",
		emailaddfail: "Oops, it seems there is something wrong! please try again later!",
	}

};

$(document).ready(function() {

     $("a[data-toggle=tooltip], [rel=tooltip]").tooltip();
     $("#column-left + #column-right + #content").addClass("span6");
     $("#column-left + #content").addClass("span9");
	var init = function(){

		/* Equal Height */

		//$('#content .product-grid > div').equalHeights();

		/* Search */
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

		/* Ajax Cart */
		$('#cart > .heading a').live('click', function() {
			$('#cart').addClass('active');

			$('#cart').load('index.php?route=module/cart #cart > *');

			$('#cart').live('mouseleave', function() {
				$(this).removeClass('active');
			});
		});

		/* Mega Menu */
		$('.navbar ul > li > a + ul').each(function(index, element) {
			// IE6 & IE7 Fixes
			if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
				var category = $(element).find('a');
				var columns = $(element).find('ul').length;

				$(element).css('width', (columns * 143) + 'px');
				$(element).find('ul').css('float', 'left');
			}

			var menu = $('.navbar').offset();
			var dropdown = $(this).parent().offset();

			i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('.navbar').outerWidth());

			if (i > 0) {
				$(this).css('margin-left', '-' + (i + 5) + 'px');
			}
		});

		// IE6 & IE7 Fixes
		if ($.browser.msie) {
			if ($.browser.version <= 6) {
				$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');

				$('#column-right + #content').css('margin-right', '195px');

				$('.box-category ul li a.active + ul').css('display', 'block');
			}

			if ($.browser.version <= 7) {
				$('#menu > ul > li').bind('mouseover', function() {
					$(this).addClass('active');
				});

				$('#menu > ul > li').bind('mouseout', function() {
					$(this).removeClass('active');
				});
			}
		}

		$('.success img, .warning img, .attention img, .information img').live('click', function() {
			$(this).parent().fadeOut('slow', function() {
				$(this).remove();
			});
		});

		var myWidth = 0, myHeight = 0;
		if( typeof( window.innerWidth ) == 'number' ) {
		    //Non-IE
		    myWidth = window.innerWidth;
		    myHeight = window.innerHeight;
		} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
		    //IE 6+ in 'standards compliant mode'
		    myWidth = document.documentElement.clientWidth;
		    myHeight = document.documentElement.clientHeight;
		}

		if(myWidth < 776) {

			$("#footer h3.header").click(function () {
					$(this).find('i').toggleClass("icon-minus");
					$(this).toggleClass("active");
					$(this).parent().find("ul").slideToggle('medium');
			});
			$(".box .box-heading, #footer h3.header").append('<i class="icon-plus pull-right"></i>');
			$(".box .box-heading").click(function () {
					$(this).find('i').toggleClass("icon-minus");
					$(this).toggleClass("active");
					$(this).parent().find(".box-content").slideToggle('medium');
			});


		}

		$('#myCarousel .item:first').addClass('active');

		// Tooltips
	    $('.socialMedia a').tooltip();

	    //email subscription
		if ($('#email').length) {
			var e = new email();
			e.init();
		}

	};

	/* EMAIL SUBSCRIPTION SECTION START
	*
	*  This part for the Email Subscription
	*/

    var email = function () {

        var timeout, email, el = $('#email'),
            form = $('#emailform'),
            button = $('#submitbutton');


        //init
        function init() {
			setStatus(params.texts.emailstatus);

			//add event handler for validation and submiting
			el.bind('keyup', keyupHandler);
			form.bind('submit', submitEmail);

			//first check of email input
			check();
        }

        //checks the input after 500 ms
        function keyupHandler() {
            clearTimeout(timeout);
            timeout = setTimeout(function () {
                check();
            }, 500);
        }

        //sets the status
        function setStatus(status) {
            $('#emailstatus').html(status);
        }

        //submits the email address
        function submitEmail() {

            //make email lowercase
            email = el.val().toLowerCase();

            //only when its an email
            if (verify(email)) {
                //unbind event and clear interval to prevent false status
                el.unbind('keyup');
				//disable the button
				button.attr('disabled','disabled');
                setStatus(params.texts.emailwait);
                //ajax call
                $.post("emailSubscribe.php", {
                    email: $.trim(email)
                }, function (data) {
					//enable the button
					button.removeAttr('disabled');
                    if (data.success) {
                        //set status and clear the input
                        setStatus(params.texts.emailadded);
                        el.val('');
                    } else {
                        //set status and rebind the keyupHandler
                        setStatus(params.texts.emailaddfail);
                        el.bind('keyup', keyupHandler);
                    }
                }, "json");
            } else {
                //email address is invalid
                setStatus(params.texts.emailinvalid);
                //focus field
                el.focus().select();
            }
            return false;
        }

        //checks the email address an change status + color of button
        function check() {
            email = el.val();
            if (verify(email)) {
                //valid email
				setStatus(params.texts.emailok);
            } else {
                //invalid email
                setStatus(params.texts.emailstatus);
            }
        }

        //verify the syntax of an email


        function verify(email) {
            email = $.trim(email.toLowerCase());
            return (email && /^([\w-]+(?:\.[\w-]+)*)\@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$|(\[?(\d{1,3}\.){3}\d{1,3}\]?)$/.test(email))
        }

        //public functions
        return {
            init: function () {
                init();
            }
        };
    };

	/* EMAIL SUBSCRIPTION SECTION END*/

	//init the whole thing
	init();

	/* ---------------------------------------------------------------------- */
	/*	Products Carousel & Banners Carousel
	/* ---------------------------------------------------------------------- */

	(function() {

		var $carousel = $('.products-carousel, .banners-carousel');

		if( $carousel.length ) {

			var scrollCount;

			function getWindowWidth() {

				if( $(window).width() < 480 ) {
					scrollCount = 1;
				} else if( $(window).width() < 768 ) {
					scrollCount = 2;
				} else if( $(window).width() < 960 ) {
					scrollCount = 3;
				} else {
					scrollCount = 4;
				}

			}

			function initCarousel( carousels ) {

				carousels.each(function() {

					var $this  = $(this);

					$this.jcarousel({
						animation           : 600,
						easing              : 'easeOutCubic',
						scroll              : scrollCount,
						itemVisibleInCallback : function() {
							onBeforeAnimation : resetPosition( $this );
							onAfterAnimation  : resetPosition( $this );
						}
					});

				});

			}

			function adjustCarousel() {

				$carousel.each(function() {

					var $this    = $(this),
						$lis     = $this.children('li')
						newWidth = $lis.length * $lis.first().outerWidth( true ) + 100;

					getWindowWidth();

					// Resize only if width has changed
					if( $this.width() !== newWidth ) {

						$this.css('width', newWidth )
							 .data('resize','true');

						initCarousel( $this );

						$this.jcarousel('scroll', 1);

						var timer = window.setTimeout( function() {
							window.clearTimeout( timer );
							$this.data('resize', null);
						}, 600 );

					}

				});

			}

			function resetPosition( elem ) {
				if( elem.data('resize') )
					elem.css('left', '0');
			}

			getWindowWidth();

			initCarousel( $carousel );

			// Detect swipe gestures support
			/*if( Modernizr.touch ) {

				function swipeFunc( e, dir ) {

					var $carousel = $(e.currentTarget);

					if( dir === 'left' )
						$carousel.parent('.jcarousel-clip').siblings('.jcarousel-next').trigger('click');

					if( dir === 'right' )
						$carousel.parent('.jcarousel-clip').siblings('.jcarousel-prev').trigger('click');

				}

				$carousel.swipe({
					swipeLeft       : swipeFunc,
					swipeRight      : swipeFunc,
					allowPageScroll : 'auto'
				});
			}*/

			// Window resize
			$(window).on('resize', function() {

				var timer = window.setTimeout( function() {
					window.clearTimeout( timer );
					adjustCarousel();
				}, 30 );

			});

		}

	})();

	/* end Projects Carousel & Post Carousel */

});

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
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#cart-total').html(json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['success']) {
				$('#notification').after('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#wishlist-total').html(json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}

function addToCompare(product_id) {
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

				$('.success').fadeIn('slow');

				$('#compare-total').html(json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}
		}
	});
}

function openQuickView(product_id, product_name) {
	var btn = $(this);
	$(".productDetails").html('');
	$("#myModal .modal-header h3").html(product_name);
	$("#myModal .modal-body").html('').append("<h3>Loading...</h3>");
	$('#myModal').modal({
		keyboard: false
	});
	$.ajax({
		url: 'index.php?route=product/product&product_id=' + product_id,
		type: 'post',
		dataType: "html",
		success: function(data) {
			$(".productDetails").append(data);
			var details = $(".productDetails .product-info").html();
			$("#myModal .modal-body").html($('<div class="product-info"/>').append(details));
			//$("#myModal .modal-body .product-info").dialog({title: productName ,modal:true,width:700,height:400,zIndex: 9999, resizable:false, draggable:true});
		}
	});
}

$.fn.equalHeights = function(px) {
	$(this).each(function(){
		var currentTallest = 0;
		$(this).children().each(function(i){
			if ($(this).height() > currentTallest) { currentTallest = $(this).height(); }
		});
		//if (!px || !Number.prototype.pxToEm) currentTallest = $(currentTallest).pxToEm(); //use ems unless px is specified
		// for ie6, set height since min-height isn't supported
		if ($.browser.msie && $.browser.version == 6.0) { $(this).children().css({'height': currentTallest}); }
		$(this).children().css({'min-height': currentTallest});
	});
	return this;
};