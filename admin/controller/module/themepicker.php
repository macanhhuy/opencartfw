<?php
class ControllerModuleThemepicker extends Controller {
	private $error = array();

	public function index() {

		$this->language->load('module/themepicker');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('tool/image');

		// BODY BACKGROUND IMAGE

		if (isset($this->request->post['bodyBgImg'])) {
			$this->data['bodyBgImg'] = $this->request->post['bodyBgImg'];
			$bodyBgImg = $this->request->post['bodyBgImg'];
		} else {
			$this->data['bodyBgImg'] = '';
		}

		// HEADER BACKGROUND IMAGE
		if (isset($this->request->post['headerBgImg'])) {
			$this->data['headerBgImg'] = $this->request->post['headerBgImg'];
			$headerBgImg = $this->request->post['headerBgImg'];
		} else {
			$this->data['headerBgImg'] = '';
		}


		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('themepicker', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		// COLOUR PICKER FILES
		$this->document->addStyle('view/stylesheet/jquery.colorpicker.css');
		$this->document->addScript('view/javascript/jquery/jquery.colorpicker.js');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['tab_module'] = $this->language->get('tab_module');

		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/themepicker', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/themepicker', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		// CUSTOM FOOTER ARRAY
        $admin_data = array(

			// GENERAL SETTINGS
			'reaponsive_status',
			'prdList_defaultView',

			// CUSTOM FONT SETTINGS
			'fontSettings_status',
			'Body_font',
			'Body_font_size',
			'Body_font_weight',
			'PageTitle_font',
			'PageTitle_font_size',
			'PageTitle_font_weight',
			'PageTitle_transform',
			'otherHeading_font',
			'otherHeading_font_weight',
			'otherHeading_transform',
			'Navigation_font',
			'Navigation_font_size',
			'Navigation_font_weight',
			'Navigation_transform',
			'Price_font_weight',
			'Price_font',
			'Button_font',
			'Button_font_weight',
			'Button_font_transform',
			'other_font',
			'other_font_weight',
			'other_font_transform',

			// PRDOUCT PAGE SETTINGS
			'productZoom',
			'reviewTab',
			'thumbOptions',
			'productLayout',


			// MENU SETTINGS
			'menu_AllCategory',
			'customMenu_status',
			'menu1_item',	'menu1_item_url',
				'subMenu1_item1',	'subMenu1_item2',	'subMenu1_item3',
				'subMenu1_item4',	'subMenu1_item5',	'subMenu1_item6',
				'subMenu1_item7',	'subMenu1_item8',	'subMenu1_item9',
				'subMenu1_item10',

				'subMenu1_item_url1',	'subMenu1_item_url2',	'subMenu1_item_url3',
				'subMenu1_item_url4',	'subMenu1_item_url5',	'subMenu1_item_url6',
				'subMenu1_item_url7',	'subMenu1_item_url8',	'subMenu1_item_url9',
				'subMenu1_item_url10',

			'menu_item_status',
				'menu_item1',	'menu_item2',	'menu_item3',
				'menu_item4',	'menu_item5',
				'menu_item1_url',	'menu_item2_url',	'menu_item3_url',
				'menu_item4_url',	'menu_item5_url',

			'informationMenu_status',

			// LOGO SETTINGS
			'logoPosition_status',
			'logoLeft',
			'logoTop',
			'logoBG_color',
			'logoSpaceAround_LR',
			'logoSpaceAround_TB',


			'FT_Status',
			'FT_Status_home',

			'FT_about_Status',
			'FT_about_Title',
			'FT_about_Text',

			'FT_twitter_Status',
			'FT_twitter_Title',
			'FT_twitter_Tweets',
			'FT_twitter_User',

			'FT_fb_Status',
			'FT_fb_Title',
			'FT_fb_ID',

			// FOOTER SOCIAL LINKS
			'socialLink_fb_Status',
			'socialLink_fb',
			'socialLink_twitter_Status',
			'socialLink_twitter',
			'socialLink_youtube_Status',
			'socialLink_youtube',
			'socialLink_google_Status',
			'socialLink_google',
			'socialLink_mailTo_Status',
			'socialLink_mailTo',
			'socialLink_addThis_Status',
			'socialLink_addThis',

			'copyrightText',

			// FOOTER CONTACT US
			'FT_Contact_status',
			'FT_Contact_phStatus',
			'FT_Contact_ph',
			'FT_Contact_ph1',
			'FT_Contact_faxStatus',
			'FT_Contact_fax',
			'FT_Contact_fax1',
			'FT_Contact_emailStatus',
			'FT_Contact_email',

			// READY TO USE THEME
			'theme',
			'theme_option',
			'theme_optionStatus',

			// GENERAL THEME COLORS
			'bodyBg',
			'bodyBgImg',
			'bodyBgImg_preview',
			'bodyBgImgRepeat',
			'bodyBgImgPosition',
			'globalColour',
			'globalColourRing',
			'pageBg',
			'pageShadow',
			'ImageBox',
			'fontColor',

			'btColor',
			'btColor_hover',
			'btFontColor',
			'btFontColor_hover',

			'btColor1',
			'btColor1_hover',
			'btFontColor1',
			'btFontColor1_hover',

			'LinkColor',
			'LinkColor_hover',
			'LinkBtColor',
			'LinkBtFontColor',
			'LinkBtColor_hover',
			'LinkBtFontColor_hover',

			'arrowBg',
			'arrowBg_hover',
			'arrowBgRing',
			'arrowBgRing_hover',

			'Header',

			'tableListHeader',
			'tableListHeaderFont',
			'tableListFont',
			'tableListBorder_right',
			'tableListBorder_bottom',

			// PAGE TOP HEADER SECTION
			'headerBg',
			'headerBgImg',
			'headerBgImg_preview',
			'headerBgImgRepeat',
			'headerBgImgPosition',
			'Breadcrumb_Arrow',
			'Logo',
			'Header_text',
			'Header_Link',
			'Header_Link_hover',

			'Nav',
			'Nav_hover',
			'NavFont',
			'NavFont_hover',
			'NavSub',
			'NavSub_hover',
			'NavSubFont',
			'NavSubFont_hover',
			'NavSubBorder',

			'homeBt',
			'homeBtRing',
			'homeBt_hover',

			'searchBt',
			'searchBtRing',
			'searchBt_hover',
			'searchBtRing_hover',

			// PRODUCT BOX COLORS
			'RefinCateHdBg',
			'RefinCateHdFontColor',
			'RefinCateBg',
			'RefinCateFontColour',
			'prdBack',
			'prdName',
			'prdLinks',
			'prdLinks_hover',
			'prdText',
			'prdHover_Bg',
			'PriceBg',
			'Price',
			'OldPrice',
			'PriceRing',
			'cartBt',
			'cartBtRing',
			'cartBt_hover',
			'cartBtRing_hover',

			// HOME PAGE MAIN BANNER FEATURE PRODUCT MODULE
			'bannerPosition',
			'SlideShow_Mod_status',
			'SlideShow_Mod',
			'SlideShow_Type',
			'featuredTitleBg',
			'featuredTitleFont',
			'featuredBg',
			'featuredHover_Bg',
			'featuredPrdText',
			'featuredArrow',
			'featuredArrow_hover',
			'featuredPriceBg',
			'featuredPrice',
			'featuredPriceOld',
			'featuredCrtBt',
			'featuredCrtBt_hover',
			'featuredCrtBtRing',
			'featuredCrtBtRing_hover',

			// SLIDE SHOW SETTINGS
			'slideshow_Effect',
			'slideshow_animSpeed',
			'slideshow_pauseTime',
			'slideshow_startSlide',
			'slideshow_directionNav',
			'slideshow_controlNav',
			'slideshow_pauseOnHover',

			// FOOTER
			'FooterBg',
			'FooterSocial',
			'FooterSocialRing',
			'FooterSocial_hover',
			'FooterSocialRing_hover',
			'contactIcons',


			// CUSTOM CSS
			'CustomCSS_Status',
			'CustomJS_Status',
			'customFile_Status',
			'CustomCSS_file',
			'CustomCSS',
			'CustomJS'


		);

        foreach ($admin_data as $admin_val) {
            if (isset($this->request->post[$admin_val])) {
                $this->data[$admin_val] = $this->request->post[$admin_val];

            } else {
                $this->data[$admin_val] = $this->config->get($admin_val);

            }


        }

		$this->data['text_image_manager'] = 'Image manager';

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$getLayouts = $this->data['layouts'];

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();


		$this->template = 'module/themepicker.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		// BODY BG IMAGE PREVIEW
		if (isset($this->data['bodyBgImg']) && $this->data['bodyBgImg'] != "" && file_exists(DIR_IMAGE . $this->data['bodyBgImg'])) {
			$this->data['bodyBgImg_preview'] = $this->model_tool_image->resize($this->data['bodyBgImg'], 100, 100);
		} else {
			$this->data['bodyBgImg_preview'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		// HEADER IMAGE PREVIEW
		if (isset($this->data['headerBgImg']) && $this->data['headerBgImg'] != "" && file_exists(DIR_IMAGE . $this->data['headerBgImg'])) {
			$this->data['headerBgImg_preview'] = $this->model_tool_image->resize($this->data['headerBgImg'], 100, 100);
		} else {
			$this->data['headerBgImg_preview'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		// NO IMAGE
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);


		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/themepicker')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>