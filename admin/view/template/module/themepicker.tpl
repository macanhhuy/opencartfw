<?php echo $header; ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/tp-module.css" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/bootstrap.min.css" />
<div id="content" class="theme-picker">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<div class="alert alert-success" style="display: none">
  		Well done! You successfully update.
	</div>
<script type="text/javascript">
function submitform(){
	$.post('<?php echo $action; ?>', $('#form').serialize(),function(response){
		$('.alert').show();
		$('.alert').hide('slow');
	});
}
</script>
	<div class="box">
		<div class="heading">
			<h1><i class="icon-wrench icon-white"></i><?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="submitform();" class="btn btn-primary" style="margin-right: 10px;"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-warning"><?php echo $button_cancel; ?></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

				<div class="htabs" id="mainTabs">
					<a href="#themesetting">Theme Settings</a>
					<a href="#themes">Themes</a>
					<a href="#themecolor">Theme Colors</a>
					<a href="#customcss">Custom Code</a>
				</div>

				<!-- CUSTOM THEME SETTINGS -->
				<div id="themesetting" class="htabs-content">
					<table cellpadding="0" cellspacing="0" width="100%" border="0">
						<tr>
							<td valign="top" >
								<div id="tabs1" class="vtabs">
									<a href="#tab_general_settings">General</a>
									<a href="#tab_menu_settings">Menu</a>
									<a href="#tab_slideshow_mod">Home slideshow settings</a>
									<a href="#tab_fonts_settings">Fonts</a>
									<a href="#tab_social_links">Footer social links</a>
									<a href="#tab_contactinfo">Footer contact details</a>
									<a href="#tab_custom_footer">Custom footer</a>
								</div>

								<div id="tab_fonts_settings" class="vtabs-content">
									<h3>
										Fonts settings
										<select name="fontSettings_status">
											<?php if ($fontSettings_status) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
											<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
											<?php } ?>
										</select>
									</h3>
									<?php
										$json = file_get_contents("view/image/theme/webfonts.json", true);
										$decode = json_decode($json, true);
										$webfonts = array();
										foreach ($decode['items'] as $key => $value) {
											// FONT FAMILY
											$item_family = $decode['items'][$key]['family'];
											$item_family_trunc =  str_replace(' ','+',$item_family);
											$webfonts[$item_family_trunc] = $item_family;
										}
										//print_r ($default);
										$defaultFont = array(
											'Arial',
											'Verdana',
											'Helvetica',
											'Lucida Grande',
											'Trebuchet MS',
											'Times New Roman',
											'Tahoma',
											'Georgia'
											);
										$FontWeight = array( 'normal', 'bold' );

									?>

									<table class="form">
										<tr>
											<td class="left">
												Body fonts<br />
												<span class="help">Select " -- " to reset</span>
											</td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="Body_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('Body_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ($webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('Body_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="Body_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('Body_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $BodyFontsSizes = array( '--', '11px', '12px', '13px', '14px', '15px', '16px', '17px', '18px' ); ?>
															Size<br />
															<select name="Body_font_size">
																<?php foreach ($BodyFontsSizes as $key) { ?>
																	<?php ($key ==  $this->config->get('Body_font_size')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
													</tr>
												</table>
												<div id="bodyFontPreview_block" class="font-preview">
													<link href='' id='bodyFontPreview' rel='stylesheet' type='text/css'>
													Grumpy wizards make toxic brew for the evil Queen and Jack.
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#bodyFontPreview_block');
													var fontUrl = $('#bodyFontPreview');
													var selectFont = $('select[name="Body_font"]');
													var selectSize = $('select[name="Body_font_size"]');
													var selectWeight = $('select[name="Body_font_weight"]')

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectSize.val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",selectSize.val());
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectSize.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",$(this).val());
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
												});
												</script>


											</td>
										</tr>

										<tr>
											<td class="left">Page title fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="PageTitle_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('PageTitle_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('PageTitle_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="PageTitle_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('PageTitle_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $PageTitleFontsSizes = array(
																'--', '18px', '19px', '20px', '21px', '22px', '23px', '24px', '25px',
																'26px', '27px', '28px', '29px', '30px', '31px', '32px', '33px',
																'34px', '35px', '36px', '37px', '38px', '39px', '40px', '41px',
																'42px', '43px', '44px', '45px', '46px', '47px', '48px', '49px', '50px'
															); ?>
															Size<br />
															<select name="PageTitle_font_size">
																<?php foreach ($PageTitleFontsSizes as $key) { ?>
																	<?php ($key ==  $this->config->get('PageTitle_font_size')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $PageTitleFontsTransform = array( '--', 'capitalize', 'lowercase', 'uppercase' ); ?>
															Text transform<br />
															<select name="PageTitle_transform">
																<?php foreach ($PageTitleFontsTransform as $key) { ?>
																	<?php ($key ==  $this->config->get('PageTitle_transform')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>

														</td>
													</tr>
												</table>
												<div id="PageTitlePreview_block" class="font-preview">
													<link href='' id='PageTitlePreview' rel='stylesheet' type='text/css'>
													Grumpy wizards make toxic brew for the evil Queen and Jack.
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#PageTitlePreview_block');
													var fontUrl = $('#PageTitlePreview');
													var selectFont = $('select[name="PageTitle_font"]');
													var selectSize = $('select[name="PageTitle_font_size"]');
													var selectWeight = $('select[name="PageTitle_font_weight"]');
													var transform = $('select[name="PageTitle_transform"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');

															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectSize.val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",selectSize.val());
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
														if(transform.val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",transform.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectSize.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",$(this).val());
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
													transform.change(function(){
														if($(this).val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",$(this).val());
														}
													});
												});

												</script>
											</td>
										</tr>

										<tr>
											<td class="left">Other heading fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="otherHeading_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('otherHeading_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('otherHeading_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="otherHeading_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('otherHeading_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $otherHeadingTransform = array( '--', 'capitalize', 'lowercase', 'uppercase' ); ?>
															Text transform<br />
															<select name="otherHeading_transform">
																<?php foreach ($PageTitleFontsTransform as $key) { ?>
																	<?php ($key ==  $this->config->get('otherHeading_transform')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>

														</td>
													</tr>
												</table>
												<div id="otherHeading_block" class="font-preview">
													<link href='' id='otherHeadingPreview' rel='stylesheet' type='text/css'>
													Grumpy wizards make toxic brew for the evil Queen and Jack.
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#otherHeading_block');
													var fontUrl = $('#otherHeadingPreview');
													var selectFont = $('select[name="otherHeading_font"]');
													var selectWeight = $('select[name="otherHeading_font_weight"]');
													var transform = $('select[name="otherHeading_transform"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
														if(transform.val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",transform.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
													transform.change(function(){
														if($(this).val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",$(this).val());
														}
													});
												});

												</script>
											</td>
										</tr>

										<tr>
											<td class="left">Navigation fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="Navigation_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('Navigation_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('Navigation_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="Navigation_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('Navigation_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $NavigationFontsSizes = array(
																'--', '11px', '12px', '13px', '14px', '15px', '16px', '17px', '18px'
															); ?>
															Size<br />
															<select name="Navigation_font_size">
																<?php foreach ($NavigationFontsSizes as $key) { ?>
																	<?php ($key ==  $this->config->get('Navigation_font_size')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $NavigationFontsTransform = array( '--', 'capitalize', 'lowercase', 'uppercase' ); ?>
															Text transform<br />
															<select name="Navigation_transform">
																<?php foreach ($NavigationFontsTransform as $key) { ?>
																	<?php ($key ==  $this->config->get('Navigation_transform')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>

														</td>
													</tr>
												</table>
												<div id="NavigationPreview_block" class="font-preview">
													<link href='' id='NavigationPreview' rel='stylesheet' type='text/css'>
													Grumpy wizards make toxic brew for the evil Queen and Jack.
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#NavigationPreview_block');
													var fontUrl = $('#NavigationPreview');
													var selectFont = $('select[name="Navigation_font"]');
													var selectSize = $('select[name="Navigation_font_size"]');
													var selectWeight = $('select[name="Navigation_font_weight"]');
													var transform = $('select[name="Navigation_transform"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectSize.val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",selectSize.val());
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
														if(transform.val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",transform.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectSize.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-size",'');
														}else {
															previewBox.css("font-size",$(this).val());
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
													transform.change(function(){
														if($(this).val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",$(this).val());
														}
													});
												});

												</script>

											</td>
										</tr>

										<tr>
											<td class="left">Price fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="Price_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('Price_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('Price_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="Price_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('Price_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>

													</tr>
												</table>
												<div id="PricePreview_block" class="font-preview" style="font-size:16px;">
													<link href='' id='PricePreview' rel='stylesheet' type='text/css'>
													Price : 1234567890
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#PricePreview_block');
													var fontUrl = $('#PricePreview');
													var selectFont = $('select[name="Price_font"]');
													var selectWeight = $('select[name="Price_font_weight"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
												});

												</script>
											</td>
										</tr>

										<tr>
											<td class="left">Button fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="Button_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('Button_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('Button_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="Button_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('Button_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $ButtonFontsTransform = array( '--', 'capitalize', 'lowercase', 'uppercase' ); ?>
															Text transform<br />
															<select name="Button_font_transform">
																<?php foreach ($ButtonFontsTransform as $key) { ?>
																	<?php ($key ==  $this->config->get('Button_font_transform')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>

														</td>
													</tr>
												</table>
												<div class="font-preview" style="font-size:16px;">
													<link href='' id='ButtonPreview' rel='stylesheet' type='text/css'>
													<span id="ButtonPreview_block" class="site-button">Sample Button</span>
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#ButtonPreview_block');
													var fontUrl = $('#ButtonPreview');
													var selectFont = $('select[name="Button_font"]');
													var selectWeight = $('select[name="Button_font_weight"]');
													var transform = $('select[name="Button_font_transform"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
															previewBox.parent().css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
															previewBox.parent().css("display",'');
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
														if(transform.val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",transform.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
															previewBox.parent().css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
															previewBox.parent().css("display",'');
														}
													});

													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
													transform.change(function(){
														if($(this).val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",$(this).val());
														}
													});
												});

												</script>

											</td>
										</tr>

										<tr>
											<td class="left">Other component fonts<br /><span class="help">Select " -- " to reset</span></td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>
															Fonts<br />
															<select name="other_font">
																<option>--</option>
																<optgroup label="HTML default fonts">
																<?php foreach ($defaultFont as $key) { ?>
																	<?php ($key ==  $this->config->get('other_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
																</optgroup>
																<optgroup label="Google fonts">
																<?php foreach ( $webfonts as $key => $face ) { ?>
																	<?php ($key ==  $this->config->get('other_font')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $face; ?></option>
																<?php } ?>
																</optgroup>
															</select>
														</td>
														<td>
															Font weight<br />
															<select name="other_font_weight">
																<option>--</option>
																<?php foreach ($FontWeight as $key) { ?>
																	<?php ($key ==  $this->config->get('other_font_weight')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>
														</td>
														<td>
															<?php $OtherFontsTransform = array( '--', 'capitalize', 'lowercase', 'uppercase' ); ?>
															Text transform<br />
															<select name="other_font_transform">
																<?php foreach ($OtherFontsTransform as $key) { ?>
																	<?php ($key ==  $this->config->get('other_font_transform')) ? $selected = 'selected' : $selected=''; ?>
																	<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
																<?php } ?>
															</select>

														</td>
													</tr>
												</table>
												<div id="OtherFontsPreview_block" class="font-preview">
													<link href='' id='OtherFontsPreview' rel='stylesheet' type='text/css'>
													Grumpy wizards make toxic brew for the evil Queen and Jack.
												</div>
												<script>
												$(document).ready(function(e) {
													var previewBox = $('#OtherFontsPreview_block');
													var fontUrl = $('#OtherFontsPreview');
													var selectFont = $('select[name="other_font"]');
													var selectWeight = $('select[name="other_font_weight"]');
													var transform = $('select[name="other_font_transform"]');

													function selectedFont(){
														if(selectFont.val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	selectFont.val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+selectFont.val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
														if(selectWeight.val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",selectWeight.val());
														}
														if(transform.val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",transform.val());
														}
													}
													selectedFont();

													selectFont.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-family",'');
															previewBox.css("display",'none');
														}else {
															var font = 	$(this).val().replace(/\+/g," ");
															var link = "http://fonts.googleapis.com/css?family="+$(this).val();
															fontUrl.attr('href', link);
															previewBox.css("font-family",'"'+font+'"');
															previewBox.css("display",'');
														}
													});
													selectWeight.change(function(){
														if($(this).val() == '--'){
															previewBox.css("font-weight",'');
														}else {
															previewBox.css("font-weight",$(this).val());
														}
													});
													transform.change(function(){
														if($(this).val() == '--'){
															previewBox.css("text-transform",'');
														}else {
															previewBox.css("text-transform",$(this).val());
														}
													});
												});

												</script>
											</td>
										</tr>

									</table>
								</div>

								<div id="tab_menu_settings" class="vtabs-content">
									<h3>Navigation options</h3>
									<table class="form">
										<tr>
											<td class="left">Menu options</td>
											<td class="left">
												<input id="informationMenu_status" name="informationMenu_status" type="checkbox" <?php if ($informationMenu_status) { ?>checked="checked"<?php }?> value="1" />
												<label for="informationMenu_status">Display information menu</label>
											</td>
										</tr>

										<tr>
											<td class="left">Custom dropdown menu</td>
											<td class="left">
												<select name="customMenu_status">
													<?php if ($customMenu_status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br /><br />
												<table class="sub-from1">
													<tr>
														<td>
															<table class="menu1" cellpadding="0" cellspacing="0">
																<tr class="menu-item">
																	<td>Menu Item name<br /><input id="menu1_item" value="<?php echo $menu1_item; ?>" name="menu1_item" type="text" /></td>
																	<td>Menu Item URL<br /><input id="menu1_item_url" value="<?php echo $menu1_item_url; ?>" name="menu1_item_url" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item1" value="<?php echo $subMenu1_item1; ?>" name="subMenu1_item1" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url1" value="<?php echo $subMenu1_item_url1; ?>" name="subMenu1_item_url1" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item2" value="<?php echo $subMenu1_item2; ?>" name="subMenu1_item2" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url2" value="<?php echo $subMenu1_item_url2; ?>" name="subMenu1_item_url2" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item3" value="<?php echo $subMenu1_item3; ?>" name="subMenu1_item3" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url3" value="<?php echo $subMenu1_item_url3; ?>" name="subMenu1_item_url3" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item4" value="<?php echo $subMenu1_item4; ?>" name="subMenu1_item4" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url4" value="<?php echo $subMenu1_item_url4; ?>" name="subMenu1_item_url4" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item5" value="<?php echo $subMenu1_item5; ?>" name="subMenu1_item5" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url5" value="<?php echo $subMenu1_item_url5; ?>" name="subMenu1_item_url5" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item6" value="<?php echo $subMenu1_item6; ?>" name="subMenu1_item6" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url6" value="<?php echo $subMenu1_item_url6; ?>" name="subMenu1_item_url6" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item7" value="<?php echo $subMenu1_item7; ?>" name="subMenu1_item7" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url7" value="<?php echo $subMenu1_item_url7; ?>" name="subMenu1_item_url7" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item8" value="<?php echo $subMenu1_item8; ?>" name="subMenu1_item8" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url8" value="<?php echo $subMenu1_item_url8; ?>" name="subMenu1_item_url8" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item9" value="<?php echo $subMenu1_item9; ?>" name="subMenu1_item9" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url9" value="<?php echo $subMenu1_item_url9; ?>" name="subMenu1_item_url9" type="text" /></td>
																</tr>
																<tr>
																	<td>Name<input id="subMenu1_item10" value="<?php echo $subMenu1_item10; ?>" name="subMenu1_item10" type="text" /></td>
																	<td>URL<input id="subMenu1_item_url10" value="<?php echo $subMenu1_item_url10; ?>" name="subMenu1_item_url10" type="text" /></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>

											</td>
										</tr>
										<tr>
											<td class="left">Custom menu items</td>
											<td class="left">
												<select name="menu_item_status">
													<?php if ($menu_item_status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br /><br />
												<table class="sub-from1">
													<tr>
														<td>
															<table class="menu1" cellpadding="0" cellspacing="0">
																<tr>
																	<td>
																		Menu item 1<br />
																		<input name="menu_item1" value="<?php echo $menu_item1; ?>" id="menu_item1" type="text" />
																	</td>
																	<td>
																		Menu URL<br />
																		<input name="menu_item1_url" value="<?php echo $menu_item1_url; ?>" id="menu_item1_url" type="text" />
																	</td>
																</tr>
																<tr>
																	<td>
																		Menu item 2<br />
																		<input name="menu_item2" value="<?php echo $menu_item2; ?>" id="menu_item2" type="text" />
																	</td>
																	<td>
																		Menu URL<br />
																		<input name="menu_item2_url" value="<?php echo $menu_item2_url; ?>" id="menu_item2_url" type="text" />
																	</td>
																</tr>
																<tr>
																	<td>
																		Menu item 3<br />
																		<input name="menu_item3" value="<?php echo $menu_item3; ?>" id="menu_item3" type="text" />
																	</td>
																	<td>
																		Menu URL<br />
																		<input name="menu_item3_url" value="<?php echo $menu_item3_url; ?>" id="menu_item3_url" type="text" />
																	</td>
																</tr>
																<tr>
																	<td>
																		Menu item 4<br />
																		<input name="menu_item4" value="<?php echo $menu_item4; ?>" id="menu_item4" type="text" />
																	</td>
																	<td>
																		Menu URL<br />
																		<input name="menu_item4_url" value="<?php echo $menu_item4_url; ?>" id="menu_item4_url" type="text" />
																	</td>
																</tr>
																<tr>
																	<td>
																		Menu item 5<br />
																		<input name="menu_item5" value="<?php echo $menu_item5; ?>" id="menu_item5" type="text" />
																	</td>
																	<td>
																		Menu URL<br />
																		<input name="menu_item5_url" value="<?php echo $menu_item5_url; ?>" id="menu_item5_url" type="text" />
																	</td>
																</tr>
															</table>
														</td>

													</tr>
												</table>
											</td>
										</tr>
									</table>
								</div>

								<div id="tab_general_settings" class="vtabs-content">
									<table class="form">
										<tr>
											<td class="left">Responsive theme</td>
											<td class="left">
												<select name="reaponsive_status">
													<?php if ($reaponsive_status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Product list page default view</td>
											<td class="left">
												<?php $PrdDisplay = array( 'Grid view' => 'grid', 'List view' => 'list'); ?>
												<select name="prdList_defaultView">
													<?php foreach ($PrdDisplay as $key => $value) { ?>
														<?php ($value ==  $this->config->get('prdList_defaultView')) ? $selected = 'selected' : $selected=''; ?>
														<option value="<?php echo $value; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
									</table>

									<h3>Logo options</h3>
									<table class="form">
										<tr>
											<td class="left">Logo</td>
											<td class="left">
												<input id="logoPosition_status" name="logoPosition_status" type="checkbox" <?php if ($logoPosition_status) { ?>checked="checked"<?php }?> value="1" />
												<label for="logoPosition_status">Display out side menu</label>
											</td>
										</tr>
										<tr>
											<td class="left">Logo Position</td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>Left<br /><input id="logoLeft" name="logoLeft" value="<?php echo $logoLeft; ?>" type="text" /></td>
														<td>Top<br /><input id="logoTop" name="logoTop" value="<?php echo $logoTop; ?>" type="text" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td class="left">Space around logo</td>
											<td class="left">
												<table class="sub-from1">
													<tr>
														<td>Top - Bottom<br /><input id="logoSpaceAround_TB" name="logoSpaceAround_TB" value="<?php echo $logoSpaceAround_TB; ?>" type="text" /></td>
														<td>Left - Right<br /><input id="logoSpaceAround_LR" name="logoSpaceAround_LR" value="<?php echo $logoSpaceAround_LR; ?>" type="text" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td class="left">Background color</td>
											<td class="left"><input id="logoBG_color" name="logoBG_color" value="<?php echo $logoBG_color; ?>" class="rgb" type="text" /></td>
										</tr>

									</table>

									<h3>Product page options</h3>
									<table class="form">
										<tr>
											<td class="left">Product page layout</td>
											<td class="left">
												<input id="productLayout" name="productLayout" type="checkbox" <?php if ($productLayout) { ?>checked="checked"<?php }?> value="oc" />
												<label for="productLayout">Enable OpenCart layout</label>
											</td>
										</tr>
										<tr class="ocLayout">
											<td class="left">Product review</td>
											<td class="left">
												<input id="reviewTab" name="reviewTab" type="checkbox" <?php if ($reviewTab) { ?>checked="checked"<?php }?> value="1" />
												<label for="reviewTab">Display review in tabs</label>
											</td>
										</tr>
										<tr class="ocLayout">
											<td class="left">Additional images</td>
											<td class="left">
												<input id="thumbOptions" name="thumbOptions" type="checkbox" <?php if ($thumbOptions) { ?>checked="checked"<?php }?> value="1" />
												<label for="thumbOptions">Display below main image</label>
											</td>
										</tr>
										<tr>
											<td class="left">Product image zoom options</td>
											<td class="left">
												<select name="productZoom">
													<?php if ($productZoom) { ?>
													<option value="1" selected="selected">Normal popup</option>
													<option value="0">Cloud zoom</option>
													<?php } else { ?>
													<option value="1">Normal popup</option>
													<option value="0" selected="selected">Cloud zoom</option>
													<?php } ?>
												</select>
											</td>
										</tr>
									</table>


								</div>
								<div id="tab_slideshow_mod" class="vtabs-content slideshowOptions">
									<h3>Slide show settings</h3>
									<table class="form">
										<tr>
											<td class="left">Display products on slideshow</td>
											<td class="left">
												<select name="SlideShow_Mod_status" id="SlideShow_Mod_status">
													<?php if ($SlideShow_Mod_status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>

												<?php $slideshowProducts = array(
													'--' 		=> '--',
													'featured' 	=> 'Featured Products',
													'best' 		=> 'Best Sellers',
													'special' 	=> 'Special Offers',
													'latest' 	=> 'Latest Products'

												); ?>
												<select name="SlideShow_Mod">
													<?php foreach ($slideshowProducts as $key => $value) { ?>
														<?php ($key ==  $this->config->get('SlideShow_Mod')) ? $selected = 'selected' : $selected=''; ?>
														<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $value; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
									</table>

									<h3>Slideshow type</h3>
									<div class="from-wrp">
										<span class="radio">
											<input id="ss_none" name="SlideShow_Type" type="radio" <?php if ($SlideShow_Type == '--' || $SlideShow_Type == '') { ?>checked="checked"<?php }?> value="--" />
											<label class="rgen-button" for="ss_none">
												<span></span>Default Opencart
											</label>
										</span>
										<span class="radio">
											<input id="ss_full" name="SlideShow_Type" type="radio" <?php if ($SlideShow_Type == 'full') { ?>checked="checked"<?php }?> value="full" />
											<label class="rgen-button" for="ss_full">
												<span></span>Full size
											</label>
										</span>
										<span class="radio">
											<input id="ss_medium" name="SlideShow_Type" type="radio" <?php if ($SlideShow_Type == 'medium') { ?>checked="checked"<?php }?> value="medium" />
											<label class="rgen-button" for="ss_medium">
												<span></span>Medium size
											</label>
										</span>
										<span class="radio">
											<input id="ss_normal" name="SlideShow_Type" type="radio" <?php if ($SlideShow_Type == 'normal') { ?>checked="checked"<?php }?> value="normal" />
											<label class="rgen-button" for="ss_normal">
												<span></span>Normal size
											</label>
										</span>
										<span class="radio">
											<input id="ss_beside_bnr" name="SlideShow_Type" type="radio" <?php if ($SlideShow_Type == 'beside_bnr') { ?>checked="checked"<?php }?> value="beside_bnr" />
											<label class="rgen-button" for="ss_beside_bnr">
												<span></span>Beside banners
											</label>
										</span>

										<br />
										<div class="normal-size" style="font-size:11px; color:#666; margin-top:15px; display:inline-block;">
											Prefered slideshow banner sizes<br />
											<strong>Full</strong> - w:1080 x h:800, <strong>Medium</strong> - w:1080 x h:630, <strong>Normal</strong> - w:940 x h:500<br /><br />

											Create banner slide set with multiple slide images from Settings > Design > Banners <br /><br />
											Set slideshow banner size in Extensions > Modules > Slideshow module<br />
										</div>
									</div>

									<h3>Home page small banners</h3>
									<div class="from-wrp">
										<span class="radio">
											<input id="bannerNone" name="bannerPosition" type="radio" <?php if ($bannerPosition == 'none' || $bannerPosition == '') { ?>checked="checked"<?php }?> value="none" />
											<label class="rgen-button" for="bannerNone">
												<span></span>Flexible position
											</label>
										</span>
										<span class="radio">
											<input id="bannerBelow" name="bannerPosition" type="radio" <?php if ($bannerPosition == 'below') { ?>checked="checked"<?php }?> value="below" />
											<label class="rgen-button" for="bannerBelow">
												<span></span>Stick below slideshow
											</label>
										</span>

										<span class="radio">
											<input id="bannerBeside" name="bannerPosition" type="radio" <?php if ($bannerPosition == 'none' || $bannerPosition == 'below' || $bannerPosition == '') { ?>disabled="disabled"<?php }?> <?php if ($bannerPosition == 'beside') { ?>checked="checked"<?php }?> value="beside" />
											<label class="rgen-button" for="bannerBeside">
												<span></span>Display beside slideshow
											</label>
										</span>
									</div>

									<h3>Slide show options</h3>
									<table class="form">
										<tr>
											<td class="left">Slide show effect</td>
											<td class="left">
												<?php $slideshowEffect = array(
													'--',
													'sliceDown',
													'sliceDownLeft',
													'sliceUp',
													'sliceUpLeft',
													'sliceUpDown',
													'sliceUpDownLeft',
													'fold',
													'fade',
													'random',
													'slideInRight',
													'slideInLeft',
													'boxRandom',
													'boxRain',
													'boxRainReverse',
													'boxRainGrow',
													'boxRainGrowReverse'
												); ?>
												<select name="slideshow_Effect">
													<?php foreach ($slideshowEffect as $key) { ?>
														<?php ($key ==  $this->config->get('slideshow_Effect')) ? $selected = 'selected' : $selected=''; ?>
														<option value="<?php echo $key; ?>" <?php echo $selected; ?>><?php echo $key; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Slide animation speed</td>
											<td class="left">
												<input id="slideshow_animSpeed" name="slideshow_animSpeed" value="<?php echo $slideshow_animSpeed; ?>" type="text" />
												<span class="help">Slide transition speed</span>
											</td>
										</tr>
										<tr>
											<td class="left">Slide pause time</td>
											<td class="left">
												<input id="slideshow_pauseTime" name="slideshow_pauseTime" value="<?php echo $slideshow_pauseTime; ?>" type="text" />
												<span class="help">How long each slide will show</span>
											</td>
										</tr>
										<tr>
											<td class="left">Start slide</td>
											<td class="left">
												<input id="slideshow_startSlide" name="slideshow_startSlide" value="<?php echo $slideshow_startSlide; ?>" type="text" />
												<span class="help">Set starting Slide (0 index)</span>
											</td>
										</tr>
										<tr>
											<td class="left">Display left right arrows</td>
											<td class="left">
												<select name="slideshow_directionNav" style="width:120px">
													<?php if ($slideshow_directionNav == 'true' || $slideshow_directionNav == '') { ?>
													<option value="true" selected="selected">Yes</option>
													<option value="false">No</option>
													<?php } else { ?>
													<option value="true">Yes</option>
													<option value="false" selected="selected">No</option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Display control navigation</td>
											<td class="left">
												<select name="slideshow_controlNav" style="width:120px">
													<?php if ($slideshow_controlNav == 'true' || $slideshow_controlNav == '') { ?>
													<option value="true" selected="selected">Yes</option>
													<option value="false">No</option>
													<?php } else { ?>
													<option value="true">Yes</option>
													<option value="false" selected="selected">No</option>
													<?php } ?>
												</select>
												<span class="help">1,2,3... navigation</span>
											</td>
										</tr>
										<tr>
											<td class="left">Pause on hover</td>
											<td class="left">
												<select name="slideshow_pauseOnHover" style="width:120px">
													<?php if ($slideshow_pauseOnHover == 'true' || $slideshow_pauseOnHover == '') { ?>
													<option value="true" selected="selected">Yes</option>
													<option value="false">No</option>
													<?php } else { ?>
													<option value="true">Yes</option>
													<option value="false" selected="selected">No</option>
													<?php } ?>
												</select>
												<span class="help">Stop animation while hovering</span>
											</td>
										</tr>
									</table>

								</div>
								<div id="tab_social_links" class="vtabs-content">
									<table class="form">
										<tr>
											<td class="left">Facebook</td>
											<td class="left">
												<input type="text" name="socialLink_fb" value="<?php echo $socialLink_fb; ?>">
												<select name="socialLink_fb_Status">
													<?php if ($socialLink_fb_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Twitter</td>
											<td class="left">
												<input type="text" name="socialLink_twitter" value="<?php echo $socialLink_twitter; ?>">
												<select name="socialLink_twitter_Status">
													<?php if ($socialLink_twitter_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Youtube</td>
											<td class="left">
												<input type="text" name="socialLink_youtube" value="<?php echo $socialLink_youtube; ?>">
												<select name="socialLink_youtube_Status">
													<?php if ($socialLink_youtube_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Google +</td>
											<td class="left">
												<input type="text" name="socialLink_google" value="<?php echo $socialLink_google; ?>">
												<select name="socialLink_google_Status">
													<?php if ($socialLink_google_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Mail to</td>
											<td class="left">
												<!--<input type="text" name="socialLink_mailTo" value="<?php echo $socialLink_mailTo; ?>"> -->
												<select name="socialLink_mailTo_Status">
													<?php if ($socialLink_mailTo_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Share this</td>
											<td class="left">
												<!--<input type="text" name="socialLink_addThis" value="<?php echo $socialLink_addThis; ?>"> -->
												<select name="socialLink_addThis_Status">
													<?php if ($socialLink_addThis_Status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>

									</table>
								</div>
								<div id="tab_contactinfo" class="vtabs-content">
									<table class="form">
										<tr>
											<td class="left">Contact status</td>
											<td class="left">
												<select name="FT_Contact_status">
													<?php if ($FT_Contact_status) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select>
											</td>
										</tr>
										<tr>
											<td class="left">Phone No.</td>
											<td class="left">
												<select name="FT_Contact_phStatus">
													<?php if ($FT_Contact_phStatus) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br />
												<input type="text" name="FT_Contact_ph" value="<?php echo $FT_Contact_ph; ?>">
												<input type="text" name="FT_Contact_ph1" value="<?php echo $FT_Contact_ph1; ?>">
											</td>
										</tr>
										<tr>
											<td class="left">Fax No.</td>
											<td class="left">
												<select name="FT_Contact_faxStatus">
													<?php if ($FT_Contact_faxStatus) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br />
												<input type="text" name="FT_Contact_fax" value="<?php echo $FT_Contact_fax; ?>">
												<input type="text" name="FT_Contact_fax1" value="<?php echo $FT_Contact_fax1; ?>">
											</td>
										</tr>
										<tr>
											<td class="left">Email</td>
											<td class="left">
												<select name="FT_Contact_emailStatus">
													<?php if ($FT_Contact_emailStatus) { ?>
													<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
													<option value="0"><?php echo $text_disabled; ?></option>
													<?php } else { ?>
													<option value="1"><?php echo $text_enabled; ?></option>
													<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
													<?php } ?>
												</select><br />
												<input type="text" name="FT_Contact_email" value="<?php echo $FT_Contact_email; ?>">
											</td>
										</tr>
									</table>
								</div>
								<div id="tab_custom_footer" class="vtabs-content">
									<div class="ft-control">
									<strong style="margin-right:20px;">R.Gen Custom Footer status</strong>
									<select name="FT_Status">
										<?php if ($FT_Status) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>

									<select name="FT_Status_home">
										<?php if ($FT_Status_home == 'common/home') { ?>
										<option value="common/home" selected="selected">Display only on home page</option>
										<option value="all">Display on all pages</option>
										<?php } else { ?>
										<option value="common/home">Display only on home page</option>
										<option value="all" selected="selected">Display on all pages</option>
										<?php } ?>
									</select>
								</div>

									<div id="tabs" class="htabs">
										<a href="#tab_about">About Us</a>
										<a href="#tab_twitter">Twitter</a>
										<a href="#tab_facebook">Facebook</a>
									</div>
									<div id="tab_about">
										<table class="form">
											<tr>
												<td>About Us Status</td>
												<td>
													<select name="FT_about_Status" id="FT_about_Status">
														<?php if ($FT_about_Status == 1) { ?>
														<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
														<option value="0"><?php echo $text_disabled; ?></option>
														<?php } else { ?>
														<option value="1"><?php echo $text_enabled; ?></option>
														<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											<tr>
												<td>Header Text:</td>
												<td><input type="text" name="FT_about_Title" value="<?php echo $FT_about_Title; ?>"></td>
											</tr>
											<tr>
												<td>About Description:</td>
												<td>
													<textarea name="FT_about_Text"><?php echo $FT_about_Text; ?></textarea>
												</td>
											</tr>
										</table>
									</div>

									<div id="tab_twitter">
										<table class="form">
											<tr>
												<td>Twitter Status</td>
												<td>
													<select name="FT_twitter_Status" id="FT_twitter_Status">
														<?php if ($FT_twitter_Status == 1) { ?>
														<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
														<option value="0"><?php echo $text_disabled; ?></option>
														<?php } else { ?>
														<option value="1"><?php echo $text_enabled; ?></option>
														<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											<tr>
												<td>Header Text:</td>
												<td><input type="text" name="FT_twitter_Title" value="<?php echo $FT_twitter_Title; ?>"></td>
											</tr>
											<tr>
												<td>Number of Tweets:</td>
												<td>
													<select name="FT_twitter_Tweets">
														<option value="1"<?php if($FT_twitter_Tweets == '1') echo ' selected="selected"';?>>1</option>
														<option value="2"<?php if($FT_twitter_Tweets == '2') echo ' selected="selected"';?>>2</option>
														<option value="3"<?php if($FT_twitter_Tweets == '3') echo ' selected="selected"';?>>3</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>Twitter Username:</td>
												<td><input type="text" name="FT_twitter_User" value="<?php echo $FT_twitter_User; ?>" /></td>
											</tr>
										</table>
									</div>

									<div id="tab_facebook">
										<table class="form">
											<tr>
												<td>Facebook Status</td>
												<td>
													<select name="FT_fb_Status" id="FT_fb_Status">
														<?php if ($FT_fb_Status == 1) { ?>
														<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
														<option value="0"><?php echo $text_disabled; ?></option>
														<?php } else { ?>
														<option value="1"><?php echo $text_enabled; ?></option>
														<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
														<?php } ?>
													</select>
												</td>
											</tr>
											<tr>
												<td>Header Text:</td>
												<td><input type="text" name="FT_fb_Title" value="<?php echo $FT_fb_Title; ?>"></td>
											</tr>
											<tr>
												<td>Facebook page ID:</td>
												<td><input type="text" name="FT_fb_ID" value="<?php echo $FT_fb_ID; ?>"></td>
											</tr>
										</table>
									</div>
								</div>
							</td>

						</tr>
					</table>
				</div>


				<div id="themes" class="htabs-content">
					<div class="style-box">
						<h3 class="header-1" style="cursor:inherit; padding-bottom:20px; margin-bottom:20px; border-bottom:1px solid #dfdfdf">
							Avaiable themes
							<select name="theme_optionStatus">
								<?php if ($theme_optionStatus) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>

							<a class="resetBt" onclick="$('.themeOptions input:radio').attr('checked', false);">Reset</a>
						</h3>

						<table class="themeOptions">
							<tr>
								<td>
									<span class="radio">
										<input id="Theme1" name="theme_option" type="radio" <?php if ($theme_option == 1) { ?>checked="checked"<?php }?> value="1" />
										<label class="rgen-button" for="Theme1">
											<span></span>Theme 1
										</label>
									</span>
									<span class="radio">
										<input id="Theme2" name="theme_option" type="radio" <?php if ($theme_option == 2) { ?>checked="checked"<?php }?> value="2" />
										<label class="rgen-button" for="Theme2">
											<span></span>Theme 2
										</label>
									</span>
									<span class="radio">
										<input id="Theme3" name="theme_option" type="radio" <?php if ($theme_option == 3) { ?>checked="checked"<?php }?> value="3" />
										<label class="rgen-button" for="Theme3">
											<span></span>Theme 3 (Full width)
										</label>
									</span>
									<span class="radio">
										<input id="Theme3_boxed" name="theme_option" type="radio" <?php if ($theme_option == 4) { ?>checked="checked"<?php }?> value="4" />
										<label class="rgen-button" for="Theme3_boxed">
											<span></span>Theme 3 (Boxed)
										</label>
									</span>
									<span class="radio">
										<input id="Theme4" name="theme_option" type="radio" <?php if ($theme_option == 5) { ?>checked="checked"<?php }?> value="5" />
										<label class="rgen-button" for="Theme4">
											<span></span>Theme 4
										</label>
									</span>
									<span class="radio">
										<input id="Theme4_boxed" name="theme_option" type="radio" <?php if ($theme_option == 6) { ?>checked="checked"<?php }?> value="6" />
										<label class="rgen-button" for="Theme4_boxed">
											<span></span>Theme 4 (Boxed)
										</label>
									</span>
								</td>

							</tr>
						</table>
						<br /><br /><br /><br />
					</div>
				</div>
				<div id="themecolor" class="htabs-content">
					<table class="column">
						<tr>
							<td>
								<div class="style-box">
									<h3 class="header-1" style="cursor:inherit;">
										Custom theme
										<select name="theme">
											<?php if ($theme) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
											<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
											<?php } ?>
										</select>

										<a class="resetBt" onclick="$('.hex, .rgb').attr('value', '');$('.hex, .rgb').attr('style', '');$('#bodyBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#bodyBgImg').attr('value', '');$('#headerBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#headerBgImg').attr('value', '');">Reset theme</a>
									</h3>
								</div>

								<div id="theme_tabs" class="vtabs">
									<a href="#tab_general_theme" class="selected">General theme colors</a>
									<a href="#tab_topheader_theme">Page top header section</a>
									<a href="#tab_productbox_theme">Product box colors</a>
									<a href="#tab_slideshow_theme">Home page slideshow product scroller</a>
									<a href="#tab_footer_theme">Footer</a>
								</div>

								<div id="tab_general_theme" class="vtabs-content">
									<!--STYLE GROUP -->
									<div class="style-box">
										<h3 class="header-1">
											General theme colors
											<span class="r">
												<a class="bt" onclick="imgPopup('#helpImg1');" id="helpImg1" rel="view/image/theme/theme_help1.jpg">Overview</a>
												<a class="bt" onclick="$('.global .hex, .global .rgb').attr('value', '');$('.global .hex, .global .rgb').attr('style', '');$('#bodyBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#bodyBgImg').attr('value', '');">Reset</a>
												<a class="toggleBt">show</a>
											</span>
										</h3>
										<div class="style-box-content global">
											<table class="form1">
												<tr>
													<td class="label"><strong class="number">1</strong> <strong>Body background</strong></td>
													<td class="field">
														<input type="text" class="hex" name="bodyBg" id="bodyBg" value="<?php echo $bodyBg; ?>">

													</td>
												</tr>
												<tr>
													<td class="label"><strong class="number">2</strong> <strong>Body background image</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td width="90" align="center">
																	<input type="hidden" name="bodyBgImg" value="<?php echo $bodyBgImg; ?>" id="bodyBgImg" />
																	<img src="<?php echo $bodyBgImg_preview; ?>" alt="" id="bodyBgImg_preview" class="PreviewImage" />

																</td>
																<td valign="top">
																	<br />
																	<div>
																		<a onclick="image_upload('bodyBgImg', 'bodyBgImg_preview');" class="bt">Upload image</a>
																		<a onclick="$('#bodyBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#bodyBgImg').attr('value', '');" class="bt">Remove image</a>
																	</div>
																	<br />

																	<select name="bodyBgImgRepeat" style="width:150px">
																		<?php if ($bodyBgImgRepeat == 'no-repeat') { ?>
																		<option value="no-repeat" selected="selected">no-repeat</option>
																		<option value="repeat-x">repeat-x </option>
																		<option value="repeat-y">repeat-y</option>
																		<option value="repeat">repeat</option>
																		<?php } elseif ($bodyBgImgRepeat == 'repeat-x') { ?>
																		<option value="no-repeat">no-repeat</option>
																		<option value="repeat-x" selected="selected">repeat-x</option>
																		<option value="repeat-y">repeat-y</option>
																		<option value="repeat">repeat</option>
																		<?php } elseif ($bodyBgImgRepeat == 'repeat-y') { ?>
																		<option value="no-repeat">no-repeat</option>
																		<option value="repeat-x">repeat-x </option>
																		<option value="repeat-y" selected="selected">repeat-y</option>
																		<option value="repeat">repeat</option>
																		<?php } else { ?>
																		<option value="no-repeat">no-repeat</option>
																		<option value="repeat-x">repeat-x </option>
																		<option value="repeat-y">repeat-y</option>
																		<option value="repeat" selected="selected">repeat</option>
																		<?php } ?>
																	</select><br />

																	<select name="bodyBgImgPosition" style="width:150px">
																		<?php if ($bodyBgImgPosition == 'left top') { ?>
																		<option value="left top" selected="selected">left top</option>
																		<option value="right top">right top</option>
																		<option value="center top">center top</option>
																		<option value="center center">center center</option>
																		<?php } elseif ($bodyBgImgPosition == 'right top') { ?>
																		<option value="left top">left top</option>
																		<option value="right top" selected="selected">right top</option>
																		<option value="center top">center top</option>
																		<option value="center center">center center</option>
																		<?php } elseif ($bodyBgImgPosition == 'center top') { ?>
																		<option value="left top">left top</option>
																		<option value="right top">right top</option>
																		<option value="center top" selected="selected">center top</option>
																		<option value="center center">center center</option>
																		<?php } else { ?>
																		<option value="left top">left top</option>
																		<option value="right top">right top</option>
																		<option value="center top">center top</option>
																		<option value="center center" selected="selected">center center</option>
																		<?php } ?>
																	</select>


																</td>
															</tr>
														</table>


													</td>
												</tr>
												<tr>
													<td class="label"><strong class="number">3</strong> <strong>Global color</strong></td>
													<td class="field"><input type="text" class="hex" name="globalColour" id="globalColour" value="<?php echo $globalColour; ?>"></td>
												</tr>
												<tr>
													<td class="label"><strong class="number">4</strong> <strong>Slide show dot color</strong></td>
													<td class="field"><input type="text" class="rgb" name="globalColourRing" id="globalColourRing" value="<?php echo $globalColourRing; ?>"></td>
												</tr>


												<tr>
													<td class="label"><strong class="number">5</strong> <strong>Page background</strong></td>
													<td class="field"><input type="text" class="hex" name="pageBg" id="pageBg" value="<?php echo $pageBg; ?>"></td>
												</tr>
												<tr>
													<td class="label"><strong class="number">6</strong> <strong>Page shadow</strong></td>
													<td class="field">
														<input type="text" class="rgb" name="pageShadow" id="pageShadow" value="<?php echo $pageShadow; ?>">
														<!--<a onclick="$('#pageShadow').attr('value', '');" class="bt">Remove shadow</a> -->
													</td>
												</tr>
												<tr>
													<td class="label"><strong class="number">7</strong> <strong>General image box</strong></td>
													<td class="field"><input type="text" class="hex" name="ImageBox" id="ImageBox" value="<?php echo $ImageBox; ?>"></td>
												</tr>
												<tr>
													<td class="label"><strong class="number">8</strong> <strong>General content font color</strong></td>
													<td class="field"><input type="text" class="hex" name="fontColor" id="fontColor" value="<?php echo $fontColor; ?>"></td>
												</tr>
												<tr>
													<td class="label"><strong class="number">9</strong> <strong>Button1 color</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Normal<br /><input type="text" class="hex" name="btColor" id="btColor" value="<?php echo $btColor; ?>"></td>
																<td>Normal text<br /><input type="text" class="hex" name="btFontColor" id="btFontColor" value="<?php echo $btFontColor; ?>"></td>
																<td>Hover<br /><input type="text" class="hex" name="btColor_hover" id="btColor_hover" value="<?php echo $btColor_hover; ?>"></td>
																<td>Hover text<br /><input type="text" class="hex" name="btFontColor_hover" id="btFontColor_hover" value="<?php echo $btFontColor_hover; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td class="label"><strong class="number">10</strong> <strong>Button2 color</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Normal<br /><input type="text" class="hex" name="btColor1" id="btColor1" value="<?php echo $btColor1; ?>"></td>
																<td>Normal text<br /><input type="text" class="hex" name="btFontColor1" id="btFontColor1" value="<?php echo $btFontColor1; ?>"></td>
																<td>Hover<br /><input type="text" class="hex" name="btColor1_hover" id="btColor1_hover" value="<?php echo $btColor1_hover; ?>"></td>
																<td>Hover text<br /><input type="text" class="hex" name="btFontColor1_hover" id="btFontColor1_hover" value="<?php echo $btFontColor1_hover; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>

												<tr>
													<td class="label"><strong class="number">11</strong> <strong>General link button color</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Normal<br /><input type="text" class="hex" name="LinkBtColor" id="LinkBtColor" value="<?php echo $LinkBtColor; ?>"></td>
																<td>Normal Text<br /><input type="text" class="hex" name="LinkBtFontColor" id="LinkBtFontColor" value="<?php echo $LinkBtFontColor; ?>"></td>
																<td>Hover<br /><input type="text" class="hex" name="LinkBtColor_hover" id="LinkBtColor_hover" value="<?php echo $LinkBtColor_hover; ?>"></td>
																<td>Hover text<br /><input type="text" class="hex" name="LinkBtFontColor_hover" id="LinkBtFontColor_hover" value="<?php echo $LinkBtFontColor_hover; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>

												<tr>
													<td class="label"><strong class="number">12</strong> <strong>General link color</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Normal<br /><input type="text" class="hex" name="LinkColor" id="LinkColor" value="<?php echo $LinkColor; ?>"></td>
																<td>Hover<br /><input type="text" class="hex" name="LinkColor_hover" id="LinkColor_hover" value="<?php echo $LinkColor_hover; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>



												<tr>
													<td class="label"><strong class="number">13</strong> <strong>Scroller arrows</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Normal<br /><input type="text" class="hex" name="arrowBg" id="arrowBg" value="<?php echo $arrowBg; ?>"></td>
																<td>Hover<br /><input type="text" class="hex" name="arrowBg_hover" id="arrowBg_hover" value="<?php echo $arrowBg_hover; ?>"></td>
																<td>Ring<br /><input type="text" class="rgb" name="arrowBgRing" id="arrowBgRing" value="<?php echo $arrowBgRing; ?>"></td>
																<td>Ring hover<br /><input type="text" class="rgb" name="arrowBgRing_hover" id="arrowBgRing_hover" value="<?php echo $arrowBgRing_hover; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>

												<tr>
													<td class="label"><strong class="number">14</strong> <strong>General headers</strong></td>
													<td class="field"><input type="text" class="hex" name="Header" id="Header" value="<?php echo $Header; ?>"></td>
												</tr>
												<tr>
													<td class="label"><strong class="number">15</strong> <strong>General table list</strong></td>
													<td class="field">
														<table class="sub-from">
															<tr>
																<td>Header<br /><input type="text" class="hex" name="tableListHeader" id="tableListHeader" value="<?php echo $tableListHeader; ?>"></td>
																<td>Header text<br /><input type="text" class="hex" name="tableListHeaderFont" id="tableListHeaderFont" value="<?php echo $tableListHeaderFont; ?>"></td>
																<td>Content text<br /><input type="text" class="hex" name="tableListFont" id="tableListFont" value="<?php echo $tableListFont; ?>"></td>
																<td>Border right<br /><input type="text" class="hex" name="tableListBorder_right" id="tableListBorder_right" value="<?php echo $tableListBorder_right; ?>"></td>
																<td>Border bottom<br /><input type="text" class="hex" name="tableListBorder_bottom" id="tableListBorder_bottom" value="<?php echo $tableListBorder_bottom; ?>"></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</div>

									</div>
								</div>
								<div id="tab_topheader_theme" class="vtabs-content">
									<!--STYLE GROUP -->
									<div class="style-box">
										<h3 class="header-1">
											Page top header section
											<span class="r">
												<a class="bt" onclick="imgPopup('#helpImg2');" id="helpImg2" rel="view/image/theme/theme_help2.jpg">Overview</a>
												<a class="bt" onclick="$('.header-section .hex, .header-section .rgb').attr('value', '');$('.header-section .hex, .header-section .rgb').attr('style', '');$('#headerBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#headerBgImg').attr('value', '');">Reset</a>
												<a class="toggleBt">show</a>
											</span>
										</h3>
										<div class="style-box-content header-section">
											<table class="form1">
											<tr>
												<td class="label"><strong class="number">1</strong> <strong>Header background</strong></td>
												<td class="field"><input type="text" class="hex" name="headerBg" id="headerBg" value="<?php echo $headerBg; ?>"></td>
											</tr>
											<tr>
												<td class="label"><strong class="number">2</strong> <strong>Header background image</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td width="90" align="center">
																<input type="hidden" name="headerBgImg" value="<?php echo $headerBgImg; ?>" id="headerBgImg" />
																<img src="<?php echo $headerBgImg_preview; ?>" alt="" id="headerBgImg_preview" class="PreviewImage" />

															</td>
															<td valign="top">
																<br />
																<div>
																	<a onclick="image_upload('headerBgImg', 'headerBgImg_preview');" class="bt">Upload image</a>
																	<a onclick="$('#headerBgImg_preview').attr('src', '<?php echo $no_image; ?>'); $('#headerBgImg').attr('value', '');" class="bt">Remove image</a>
																</div>
																<br />
																<select name="headerBgImgRepeat" style="width:150px">
																	<?php if ($headerBgImgRepeat == 'no-repeat') { ?>
																	<option value="no-repeat" selected="selected">no-repeat</option>
																	<option value="repeat-x">repeat-x </option>
																	<option value="repeat-y">repeat-y</option>
																	<option value="repeat">repeat</option>
																	<?php } elseif ($headerBgImgRepeat == 'repeat-x') { ?>
																	<option value="no-repeat">no-repeat</option>
																	<option value="repeat-x" selected="selected">repeat-x</option>
																	<option value="repeat-y">repeat-y</option>
																	<option value="repeat">repeat</option>
																	<?php } elseif ($headerBgImgRepeat == 'repeat-y') { ?>
																	<option value="no-repeat">no-repeat</option>
																	<option value="repeat-x">repeat-x </option>
																	<option value="repeat-y" selected="selected">repeat-y</option>
																	<option value="repeat">repeat</option>
																	<?php } else { ?>
																	<option value="no-repeat">no-repeat</option>
																	<option value="repeat-x">repeat-x </option>
																	<option value="repeat-y">repeat-y</option>
																	<option value="repeat" selected="selected">repeat</option>
																	<?php } ?>
																</select><br />

																<select name="headerBgImgPosition" style="width:150px">
																	<?php if ($headerBgImgPosition == 'left top') { ?>
																	<option value="left top" selected="selected">left top</option>
																	<option value="right top">right top</option>
																	<option value="center top">center top</option>
																	<option value="center center">center center</option>
																	<?php } elseif ($headerBgImgPosition == 'right top') { ?>
																	<option value="left top">left top</option>
																	<option value="right top" selected="selected">right top</option>
																	<option value="center top">center top</option>
																	<option value="center center">center center</option>
																	<?php } elseif ($headerBgImgPosition == 'center top') { ?>
																	<option value="left top">left top</option>
																	<option value="right top">right top</option>
																	<option value="center top" selected="selected">center top</option>
																	<option value="center center">center center</option>
																	<?php } else { ?>
																	<option value="left top">left top</option>
																	<option value="right top">right top</option>
																	<option value="center top">center top</option>
																	<option value="center center" selected="selected">center center</option>
																	<?php } ?>
																</select>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">3</strong> <strong>Breadcrumb arrow</strong></td>
												<td class="field"><input type="text" class="hex" name="Breadcrumb_Arrow" id="Breadcrumb_Arrow" value="<?php echo $Breadcrumb_Arrow; ?>"></td>
											</tr>
											<tr>
												<td class="label"><strong class="number">4</strong> <strong>Logo background</strong></td>
												<td class="field"><input type="text" class="hex" name="Logo" id="Logo" value="<?php echo $Logo; ?>"></td>
											</tr>
											<tr>
												<td class="label"><strong class="number">5</strong> <strong>Header text &amp; links</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Text<br /><input type="text" class="hex" name="Header_text" id="Header_text" value="<?php echo $Header_text; ?>"></td>
															<td>Links Normal<br /><input type="text" class="hex" name="Header_Link" id="Header_Link" value="<?php echo $Header_Link; ?>"></td>
															<td>Links Hover<br /><input type="text" class="hex" name="Header_Link_hover" id="Header_Link_hover" value="<?php echo $Header_Link_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">6</strong> <strong>Navigation links</strong></td>
												<td class="field">
													<table class="sub-from" cellpadding="0" cellspacing="0">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="Nav" id="Nav" value="<?php echo $Nav; ?>"></td>
															<td>Normal text<br /><input type="text" class="hex" name="NavFont" id="NavFont" value="<?php echo $NavFont; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="Nav_hover" id="Nav_hover" value="<?php echo $Nav_hover; ?>"></td>
															<td>Hover text<br /><input type="text" class="hex" name="NavFont_hover" id="NavFont_hover" value="<?php echo $NavFont_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">7</strong> <strong>Navigation dropdown</strong></td>
												<td class="field">
													<table class="sub-from" cellpadding="0" cellspacing="0">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="NavSub" id="NavSub" value="<?php echo $NavSub; ?>"></td>
															<td>Normal text<br /><input type="text" class="hex" name="NavSubFont" id="NavSubFont" value="<?php echo $NavSubFont; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="NavSub_hover" id="NavSub_hover" value="<?php echo $NavSub_hover; ?>"></td>
															<td>Hover text<br /><input type="text" class="hex" name="NavSubFont_hover" id="NavSubFont_hover" value="<?php echo $NavSubFont_hover; ?>"></td>
															<td>Border<br /><input type="text" class="hex" name="NavSubBorder" id="NavSubBorder" value="<?php echo $NavSubBorder; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">8</strong> <strong>Navigation home button</strong></td>
												<td class="field">
													<table class="sub-from" cellpadding="0" cellspacing="0">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="homeBt" id="homeBt" value="<?php echo $homeBt; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="homeBt_hover" id="homeBt_hover" value="<?php echo $homeBt_hover; ?>"></td>
															<td>Button ring<br /><input type="text" class="rgb" name="homeBtRing" id="homeBtRing" value="<?php echo $homeBtRing; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>

											<tr>
												<td class="label"><strong class="number">9</strong> <strong>Search button</strong></td>
												<td class="field">
													<table class="sub-from" cellpadding="0" cellspacing="0">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="searchBt" id="searchBt" value="<?php echo $searchBt; ?>"></td>
															<td>Normal ring<br /><input type="text" class="rgb" name="searchBtRing" id="searchBtRing" value="<?php echo $searchBtRing; ?>"></td>

															<td>Hover<br /><input type="text" class="hex" name="searchBt_hover" id="searchBt_hover" value="<?php echo $searchBt_hover; ?>"></td>
															<td>Hover ring<br /><input type="text" class="rgb" name="searchBtRing_hover" id="searchBtRing_hover" value="<?php echo $searchBtRing_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
										</div>
									</div>
								</div>
								<div id="tab_productbox_theme" class="vtabs-content">
									<!--STYLE GROUP -->
									<div class="style-box">
										<h3 class="header-1">
											Product box colors
											<span class="r">
												<a class="bt" onclick="imgPopup('#helpImg3');" id="helpImg3" rel="view/image/theme/theme_help3.jpg">Overview</a>
												<a class="bt" onclick="$('.product-box .hex, .product-box .rgb').attr('value', '');$('.product-box .hex, .product-box .rgb').attr('style', '');">Reset</a>
												<a class="toggleBt">show</a>
											</span>
										</h3>
										<div class="style-box-content product-box">
											<table class="form1">
											<tr>
												<td class="label"><strong class="number">1</strong> <strong>Refine category header</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Background<br /><input type="text" class="hex" name="RefinCateHdBg" id="RefinCateHdBg" value="<?php echo $RefinCateHdBg; ?>"></td>
															<td>Text color<br /><input type="text" class="hex" name="RefinCateHdFontColor" id="RefinCateHdFontColor" value="<?php echo $RefinCateHdFontColor; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">2</strong> <strong>Refine category box</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Background<br /><input type="text" class="hex" name="RefinCateBg" id="RefinCateBg" value="<?php echo $RefinCateBg; ?>"></td>
															<td>Text color<br /><input type="text" class="hex" name="RefinCateFontColour" id="RefinCateFontColour" value="<?php echo $RefinCateFontColour; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>

											<tr>
												<td class="label"><strong class="number">3</strong> <strong>Product box</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Background<br /><input type="text" class="hex" name="prdBack" id="prdBack" value="<?php echo $prdBack; ?>"></td>
															<td>Name<br /><input type="text" class="hex" name="prdName" id="prdName" value="<?php echo $prdName; ?>"></td>
															<td>Links<br /><input type="text" class="hex" name="prdLinks" id="prdLinks" value="<?php echo $prdLinks; ?>"></td>
															<td>Link hover<br /><input type="text" class="hex" name="prdLinks_hover" id="prdLinks_hover" value="<?php echo $prdLinks_hover; ?>"></td>
															<td>Hover BG<br /><input type="text" class="hex" name="prdHover_Bg" id="prdHover_Bg" value="<?php echo $prdHover_Bg; ?>"></td>
															<td>Text<br /><input type="text" class="hex" name="prdText" id="prdText" value="<?php echo $prdText; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">4</strong> <strong>Price tag</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Price tag<br /><input type="text" class="hex" name="PriceBg" id="PriceBg" value="<?php echo $PriceBg; ?>"></td>
															<td>Old Price<br /><input type="text" class="hex" name="OldPrice" id="OldPrice" value="<?php echo $OldPrice; ?>"></td>
															<td>Price txt<br /><input type="text" class="hex" name="Price" id="Price" value="<?php echo $Price; ?>"></td>
															<td>Price tag ring<br /><input type="text" class="rgb" name="PriceRing" id="PriceRing" value="<?php echo $PriceRing; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>

											<tr>
												<td class="label"><strong class="number">5</strong> <strong>Cart button</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="cartBt" id="cartBt" value="<?php echo $cartBt; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="cartBt_hover" id="cartBt_hover" value="<?php echo $cartBt_hover; ?>"></td>
															<td>Ring<br /><input type="text" class="rgb" name="cartBtRing" id="cartBtRing" value="<?php echo $cartBtRing; ?>"></td>
															<td>Ring hover<br /><input type="text" class="rgb" name="cartBtRing_hover" id="cartBtRing_hover" value="<?php echo $cartBtRing_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>

										</table>
										</div>

									</div>
								</div>
								<div id="tab_slideshow_theme" class="vtabs-content">
									<!--STYLE GROUP -->
									<div class="style-box">
										<h3 class="header-1">
											Home page slideshow product scroller
											<span class="r">
												<a class="bt" onclick="imgPopup('#helpImg4');" id="helpImg4" rel="view/image/theme/theme_help4.jpg">Overview</a>
												<a class="bt" onclick="$('.scroller .hex, .scroller .rgb').attr('value', '');$('.scroller .hex, .scroller .rgb').attr('style', '');">Reset</a>
												<a class="toggleBt">show</a>
											</span>
										</h3>
										<div class="style-box-content scroller">
											<table class="form1">
											<tr>
												<td class="label"><strong class="number">1</strong> <strong>Header</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Background<br /><input type="text" class="hex" name="featuredTitleBg" id="featuredTitleBg" value="<?php echo $featuredTitleBg; ?>"></td>
															<td>Text color<br /><input type="text" class="hex" name="featuredTitleFont" id="featuredTitleFont" value="<?php echo $featuredTitleFont; ?>"></td>
															<td>Arrow<br /><input type="text" class="hex" name="featuredArrow" id="featuredArrow" value="<?php echo $featuredArrow; ?>"></td>
															<td>Arrow hover<br /><input type="text" class="hex" name="featuredArrow_hover" id="featuredArrow_hover" value="<?php echo $featuredArrow_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">2</strong> <strong>Product box</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Background<br /><input type="text" class="hex" name="featuredBg" id="featuredBg" value="<?php echo $featuredBg; ?>"></td>
															<td>Hover Backgroud<br /><input type="text" class="hex" name="featuredHover_Bg" id="featuredHover_Bg" value="<?php echo $featuredHover_Bg; ?>"></td>
															<td>Link<br /><input type="text" class="hex" name="featuredPrdText" id="featuredPrdText" value="<?php echo $featuredPrdText; ?>"></td>
															<td>Price tag<br /><input type="text" class="hex" name="featuredPriceBg" id="featuredPriceBg" value="<?php echo $featuredPriceBg; ?>"></td>
															<td>Price txt<br /><input type="text" class="hex" name="featuredPrice" id="featuredPrice" value="<?php echo $featuredPrice; ?>"></td>
															<td>Old Price<br /><input type="text" class="hex" name="featuredPriceOld" id="featuredPriceOld" value="<?php echo $featuredPriceOld; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td class="label"><strong class="number">3</strong> <strong>Cart button</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="featuredCrtBt" id="featuredCrtBt" value="<?php echo $featuredCrtBt; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="featuredCrtBt_hover" id="featuredCrtBt_hover" value="<?php echo $featuredCrtBt_hover; ?>"></td>
															<td>Ring<br /><input type="text" class="rgb" name="featuredCrtBtRing" id="featuredCrtBtRing" value="<?php echo $featuredCrtBtRing; ?>"></td>
															<td>Ring hover<br /><input type="text" class="rgb" name="featuredCrtBtRing_hover" id="featuredCrtBtRing_hover" value="<?php echo $featuredCrtBtRing_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
										</div>

									</div>
								</div>
								<div id="tab_footer_theme" class="vtabs-content">
									<!--STYLE GROUP -->
									<div class="style-box">
										<h3 class="header-1">
											Footer
											<span class="r">
												<a class="bt" onclick="imgPopup('#helpImg5');" id="helpImg5" rel="view/image/theme/theme_help5.jpg">Overview</a>
												<a class="bt" onclick="$('.footer-section .hex, .footer-section .rgb').attr('value', '');$('.footer-section .hex, .footer-section .rgb').attr('style', '');">Reset</a>
												<a class="toggleBt">show</a>
											</span>
										</h3>
										<div class="style-box-content footer-section">
											<table class="form1">
											<tr>
												<td class="label"><strong class="number">1</strong> <strong>Background</strong></td>
												<td class="field"><input type="text" class="hex" name="FooterBg" id="FooterBg" value="<?php echo $FooterBg; ?>"></td>
											</tr>
											<tr>
												<td class="label"><strong class="number">2</strong> <strong>Contact icons</strong></td>
												<td class="field"><input type="text" class="hex" name="contactIcons" id="contactIcons" value="<?php echo $contactIcons; ?>"></td>
											</tr>
											<tr>
												<td class="label"><strong class="number">4</strong> <strong>Social buttons</strong></td>
												<td class="field">
													<table class="sub-from">
														<tr>
															<td>Normal<br /><input type="text" class="hex" name="FooterSocial" id="FooterSocial" value="<?php echo $FooterSocial; ?>"></td>
															<td>Hover<br /><input type="text" class="hex" name="FooterSocial_hover" id="FooterSocial_hover" value="<?php echo $FooterSocial_hover; ?>"></td>
															<td>Ring<br /><input type="text" class="rgb" name="FooterSocialRing" id="FooterSocialRing" value="<?php echo $FooterSocialRing; ?>"></td>
															<td>Hover ring<br /><input type="text" class="rgb" name="FooterSocialRing_hover" id="FooterSocialRing_hover" value="<?php echo $FooterSocialRing_hover; ?>"></td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
										</div>

									</div>
								</div>
							</td>
						</tr>
					</table>

				</div>
				<div id="customcss" class="htabs-content">
					<table class="form">
						<tr>
							<td class="left">Add Custom CSS file</td>
							<td class="left">
								<select name="customFile_Status" id="customFile_Status">
									<?php if ($customFile_Status == 1) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>
								<input type="text" class="file-path" style="width:200px; margin-left:10px;" name="CustomCSS_file" id="CustomCSS_file" value="<?php echo $CustomCSS_file; ?>">
								<br /><br />
								<span class="help">
									- Save your CSS file into this folder ==> <strong>catalog/view/theme/rgen-opencart/stylesheet/</strong><br />
									- Just enter file name in above input (Example: "custom.css")
								</span>
							</td>
						</tr>
						<tr>
							<td class="left">Add Custom CSS code</td>
							<td class="left">
								<select name="CustomCSS_Status" id="CustomCSS_Status">
									<?php if ($CustomCSS_Status == 1 || $CustomCSS_Status == '') { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select><br /><br />
								<textarea cols="100" rows="10" name="CustomCSS" id="CustomCSS"><?php echo $CustomCSS; ?></textarea>
							</td>
						</tr>
						<tr>
							<td class="left">Add Custom JS code</td>
							<td class="left">
								<select name="CustomJS_Status" id="CustomJS_Status">
									<?php if ($CustomJS_Status == 1) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select><br /><br />
								<textarea cols="100" rows="10" name="CustomJS" id="customjs"><?php echo $CustomJS; ?></textarea>
							</td>
						</tr>
					</table>
				</div>

			</form>
		</div>
	</div>
</div>


<script type="text/javascript"><!--
function image_upload(field, previewImg) {

	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + previewImg).replaceWith('<img src="' + data + '" alt="" class="PreviewImage" id="' + previewImg + '" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script>


<input id="helpImage" />
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
// SET FCK EDITOR FOR ABOUT US CONTENT
CKEDITOR.replace('FT_about_Text', {
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});

$('#tabs a').tabs();
$('#tabs1 a').tabs();
$('#theme_tabs a').tabs();
$('#language_tab a').tabs();
$('#mainTabs a').tabs();


function imgPopup (helpImg){
	$('#ThemeOverview').remove();
	$('#content').prepend('<div id="ThemeOverview" style="padding: 15px;"><img src="" /></div>');
	$('#ThemeOverview').dialog({
		dialogClass: "ThemeOverview-popup",
		open: function(event, ui) {
			$(this).find('img').attr('src',$(helpImg).attr('rel'));
			},
		title: 'Theme overview',
		bgiframe: false,
		width: 950,
		height: 600,
		resizable: false,
		modal: false,
		closeOnEscape: true
	});
}

if($('#productLayout').attr('checked') == 'checked'){
	$('.ocLayout').find('input').removeAttr('checked');
	$('.ocLayout').css({display:'none'});
}

$('#productLayout').click(function(){
	if($(this).attr('checked') == 'checked'){
		$('.ocLayout').find('input').removeAttr('checked');
		$('.ocLayout').css({display:'none'});
	}else {
		$('.ocLayout').css({display:''});
	}
});

$('#ss_full, #ss_medium, #ss_none, #ss_normal').click(function(){
	$('#bannerNone').attr('checked', 'checked');
	$('#bannerBeside').attr('disabled', 'disabled');
	$('#bannerBelow').removeAttr('disabled');

});

$('#ss_beside_bnr').click(function(){
	$('#bannerBelow, #bannerBeside').removeAttr('disabled');
	$('#bannerBeside').attr('checked', 'checked');
	$('#bannerBelow').attr('disabled', 'disabled');
});

$('#SlideShow_Mod_status').change(function(){
	if($(this).val() == 0){
		$('select[name="SlideShow_Mod"]').find('option').first().attr('selected', 'selected');
	}
});
$('select[name="SlideShow_Mod"]').change(function(){
	if($(this).val() != '--'){
		$('#SlideShow_Mod_status').find('option').first().attr('selected', 'selected');
	}
});

$("#Theme3, #Theme3_boxed, #Theme4, #Theme4_boxed").click(function(){
	$('#logoPosition_status').attr('checked','checked');
});

$('.hex').each(function(index, element) {
	$(this).colorpicker({
		hsv:false,
		altField:$(this),
		showNoneButton:true,
		altProperties: 'background-color'
	});
	$(this).click(function(){
		$('.ui-colorpicker').css({top:$(this).offset().top + 25});
	});

	if($(this).val() == ''){
		$(this).css({backgroundColor:"#fff"});
	}else{
		$(this).css({backgroundColor:"#"+$(this).val()});
	}
});
$('.rgb').each(function(index, element) {

	$(this).colorpicker({
		hsv:false,
		alpha:true,
		colorFormat: ['RGBA'],
		showNoneButton:true,
		select: function(event, color) {
					$(this).val(color.formatted);
				}
	});

	$(this).click(function(){
		$('.ui-colorpicker').css({top:$(this).offset().top + 25});
	});
});

$('select .normal').bind('select', function(){
	$('.normal-size').css({display:'block'});
});

//--></script>


<?php echo $footer; ?>