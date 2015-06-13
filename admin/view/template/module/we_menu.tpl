<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-wemenu" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-wemenu" class="form-horizontal">
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="<?php echo $name ?>" name="name" id="input-name" placeholder="<?php echo $entry_name; ?>" />
							<?php if ($error_name) { ?>
							<div class="text-danger"><?php echo $error_name; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="<?php echo $sort_order ?>" name="sort_order" id="input-sort-order" placeholder="<?php echo $entry_sort_order; ?>" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
							<select name="status" id="input-status" class="form-control">
								<?php if ($status) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-menu-class"><?php echo $entry_menu_class; ?></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="<?php echo $we_menu_class ?>" name="we_menu_class" id="input-menu-class" placeholder="<?php echo $entry_menu_class; ?>" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-tpl-row"><?php echo $entry_tpl_row; ?></label>
						<div class="col-sm-10">
							<textarea class="form-control" name="tpl_row" id="input-tpl-row" placeholder="<?php echo $entry_tpl_row; ?>"><?php echo $tpl_row ?></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-tpl-row-act"><?php echo $entry_tpl_row_act; ?></label>
						<div class="col-sm-10">
							<textarea class="form-control" name="tpl_row_act" placeholder="<?php echo $entry_tpl_row_act; ?>" id="input-tpl-row-act"><?php echo $tpl_row_act ?></textarea>
						</div>
					</div>
					<hr />
					<div class="row">
						<div class="col-sm-2">
							<ul class="nav nav-pills nav-stacked">
								<?php $first_i = reset($informations); ?>
								<?php if(!empty($we_menu)){ ?>
								<?php $i = 0; ?>
								<?php foreach($we_menu as $item){ ?>
								<?php 
									$default_name = sprintf($text_item, $i + 1);
									$tab_name = $default_name;
									if ($item['item']) {
										$tab_name = $item['item'];
									} elseif ($item['item_type'] == 'article_link' && $item['information_id'] != 0) {
										foreach ($informations as $information) {
											if ($information['information_id'] == $item['information_id']) {
												$tab_name = $information['title'];
												break;
											}
										}
									}
								?>
								<li><a href="#tab-menu-item-<?php echo $i; ?>" data-toggle="tab" data-default-name="<?php echo $default_name; ?>" id="tab-menu-item-handler-<?php echo $i++; ?>" aria-expanded="false"><?php echo $tab_name; ?></a></li>
								<?php } ?>
								<?php } ?>
								<li><a href="#tab-menu-item-add" data-toggle="tab" aria-expanded="false"><?php echo $button_add; ?></a>
							</ul>
						</div>
						<div class="col-sm-10">
							<div class="tab-content">
								<?php if(!empty($we_menu)){ ?>
								<?php $i = 0; ?>
								<?php foreach($we_menu as $item){ ?>
								<div class="tab-pane active" id="tab-menu-item-<?php echo $i; ?>">
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-item-<?php echo $i; ?>"><?php echo $entry_item; ?></label>
										<div class="col-sm-10">
											<input type="text" class="form-control tab-handler-name" data-tab-handler="#tab-menu-item-handler-<?php echo $i; ?>" value="<?php echo $item['item'] ?>" name="we_menu[<?php echo $i; ?>][item]" id="input-item-<?php echo $i; ?>" placeholder="<?php echo $entry_item; ?>" />
											<?php if ($error_item && isset($error_item[$i])) { ?>
											<div class="text-danger"><?php echo $error_item[$i]; ?></div>
											<?php } ?>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><?php echo $entry_item_type; ?></label>
										<div class="col-sm-10">
											<label class="radio-inline"><input class="show-input-select" data-show="#informations-select-<?php echo $i; ?>" type="radio" value="article_link" id="article_link<?php echo $i; ?>"<?php if ($item['item_type'] == 'article_link') { ?> checked="checked"<?php } ?> name="we_menu[<?php echo $i; ?>][item_type]" id="article_link<?php echo $i; ?>" /> <?php echo $text_article_link; ?></label>
											<label class="radio-inline"><input class="show-input-select" data-show="#link-input-<?php echo $i; ?>" type="radio" value="clear_link" name="we_menu[<?php echo $i; ?>][item_type]"<?php if ($item['item_type'] == 'clear_link') { ?> checked="checked"<?php } ?> id="clear_link<?php echo $i; ?>"/> <?php echo $text_clear_link; ?></label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="<?php if ($item['item_type'] == 'clear_link') { ?>input-item-link-<?php echo $i; ?><php } else { ?>input-item-information-<?php echo $i; ?><?php } ?>"><?php echo $entry_item_link ?></label>
										<div class="col-sm-10 show-input-select-block" id="informations-select-<?php echo $i; ?>" style="<?php if ($item['item_type'] == 'article_link') { ?>display:block;<?php } else { ?>display:none;<?php } ?>">
											<select class="form-control article-name" name="we_menu[<?php echo $i; ?>][information_id]" data-tab-handler="#tab-menu-item-handler-<?php echo $i; ?>" id="input-item-information-<?php echo $i; ?>">
												<option value="0"><?php echo $text_select; ?></option>
												<?php foreach($informations as $information) { ?>
												<option value="<?php echo $information['information_id']; ?>"<?php if ($item['information_id'] == $information['information_id']) { ?> selected="selected"<?php } ?>><?php echo $information['title']; ?></option>
												<?php } ?>
											</select>
											<?php if ($error_information_id && isset($error_information_id[$i])) { ?>
											<div class="text-danger"><?php echo $error_information_id[$i]; ?></div>
											<?php } ?>
										</div>
										<div class="col-sm-10 show-input-select-block" id="link-input-<?php echo $i; ?>" style="<?php if ($item['item_type'] == 'clear_link') { ?>display:block;<?php } else { ?>display:none;<?php } ?>">
											<input type="text" class="form-control" value="<?php echo $item['item_link']; ?>" name="we_menu[<?php echo $i; ?>][item_link]" id="input-item-link-<?php echo $i; ?>" placeholder="<?php echo $entry_item_link ?>" />
											<?php if ($error_link && isset($error_link[$i])) { ?>
											<div class="text-danger"><?php echo $error_link[$i]; ?></div>
											<?php } ?>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-item-class-<?php echo $i; ?>"><?php echo $entry_item_class; ?></label>
										<div class="col-sm-10">
											<input type="text" class="form-control" value="<?php echo $item['class']; ?>" name="we_menu[<?php echo $i; ?>][class]" id="input-item-class-<?php echo $i; ?>" placeholder="<?php echo $entry_item_class; ?>" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-item-attr-<?php echo $i; ?>"><?php echo $entry_item_attr; ?></label>
										<div class="col-sm-10">
											<input type="text" class="form-control" value="<?php echo $item['attr']; ?>" name="we_menu[<?php echo $i; ?>][attr]" id="input-item-attr-<?php echo $i; ?>" placeholder="<?php echo $entry_item_attr; ?>" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-item-sort-<?php echo $i; ?>"><?php echo $entry_item_sort; ?></label>
										<div class="col-sm-10">
											<input type="text" class="form-control" value="<?php echo $item['sort']; ?>" name="we_menu[<?php echo $i; ?>][sort]" id="input-item-sort-<?php echo $i; ?>" placeholder="<?php echo $entry_item_sort; ?>" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="input-item-enable-<?php echo $i; ?>"><?php echo $entry_item_enable; ?></label>
										<div class="col-sm-10">
											<label class="radio-inline">
												<input type="checkbox" class="form-control" value="1" name="we_menu[<?php echo $i; ?>][item_enable]" id="input-item-enable-<?php echo $i; ?>"<?php if (isset($item['item_enable'])) { ?> checked="checked"<?php } ?> />
											</label>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-10 col-sm-offset-2">
											<button type="button" class="btn btn-danger"><?php echo $button_remove; ?></button>
										</div>
									</div>
								</div>
								<?php $i++; ?>
								<?php } ?>
								<?php } ?>
							</div>
						</div>         
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

		 
					 <!--  <td class="left"><?php echo $entry_item ?></td>
						<td class="left"><?php echo $entry_item_type ?></td>
						<td class="left"><?php echo $entry_item_link ?></td>
						<td class="left"><?php echo $entry_item_class ?></td>
						<td class="left"><?php echo $entry_item_attr ?></td>
						<td class="left"><?php echo $entry_item_sort ?></td>
						<td class="left"><?php echo $entry_item_enable ?></td>
						<td></td>
					</tr>
				</thead>
				<?php $first_i = reset($informations); ?>
				<?php if(!empty($we_menu)){ ?>
				<?php $count = count($we_menu);$i = 0; ?>
				<?php foreach($we_menu as $item){ ?>
				<tbody class="menu-row<?php echo $i; ?>">
						<tr>
								<td class="left"><input type="text" value="<?php echo $item['item']; ?>" size="15" name="we_menu[<?php echo $i; ?>][item]" /></td>
								<td class="left">
										<input type="radio" class="item_type" value="article_link" id="article_link<?php echo $i; ?>"<?php if($item['item_type'] == 'article_link'){ ?> checked="checked"<?php } ?> name="we_menu[<?php echo $i; ?>][item_type]" id="" /><label for="article_link<?php echo $i; ?>">Ссылка на статью</label>
										<input type="radio" class="item_type" value="clear_link" id="clear_link<?php echo $i; ?>" name="we_menu[<?php echo $i; ?>][item_type]"<?php if($item['item_type'] == 'clear_link'){ ?> checked="checked"<?php } ?> /><label for="clear_link<?php echo $i; ?>">Обычная ссылка</label>
								</td>
								<td class="left">
										<?php if(!empty($informations) && $item['item_type'] == 'article_link'){
												$c_item_link_box = '';
												$c_article_link = 'display:none';
										}else{
												$c_item_link_box = 'display:none';
												$c_article_link = '';
										} ?>
										
												<div class="item_link_box" style="<?php echo $c_item_link_box; ?>">
												
												<input type="hidden" name="we_menu[<?php echo $i; ?>][item_link]" value="<?php echo isset($item['item_link']) ? $item['item_link'] : ''; ?>" />
												<select name="articles" class="articles">
												<?php foreach($list_inforations as $i_item){ ?>
														 <?php $checked = $item['item_type'] == 'article_link' && $i_item['information_id'] == $item['item_link'] ? 'selected="selected"' : ''; ?>
														 <option value="<?php echo $i_item['information_id'] ?>" <?php echo $checked ?>><?php echo $i_item['title'] ?></option>
												<?php } ?>
												</select>
												</div>
										<?php if($item['item_type'] == 'clear_link'){ ?>
										<div class="article_link" style="<?php echo $c_article_link; ?>">
												<input type="text" name="we_menu[<?php echo $i; ?>][item_link]" value="<?php echo isset($item['item_link']) ? $item['item_link'] : ''; ?>" />
										</div>   
										<?php } ?>
										
								</td>
								<td class="left"><input type="text" value="<?php echo $item['class']; ?>" size="10" name="we_menu[<?php echo $i; ?>][class]" /></td>
								<td class="left"><input type="text" value="<?php echo $item['attr']; ?>" size="15" name="we_menu[<?php echo $i; ?>][attr]" /></td>
								<td class="left"><input type="text" value="<?php echo $item['sort']; ?>" size="2" name="we_menu[<?php echo $i; ?>][sort]" /></td>
								<td class="left"><input type="checkbox" name="we_menu[<?php echo $i; ?>][item_enable]" <?php if(isset($item['item_enable'])){ ?>checked="checked"<?php } ?> /></td>
								<td class="left"><a onclick="$('.menu-row<?php echo $i; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
						</tr>
				</tbody>
				<?php $i++; ?>
				<?php } ?>
				<?php } ?>
				<tfoot>
					<tr>
						<td colspan="7"></td>
						<td class="left"><a onclick="addMenuItem();" class="button"><?php echo $entry_add; ?></a></td>
					</tr>
				</tfoot>
			</table>
			
			<table class="form">
				
				<tr>
					<td></td>
					<td></td>
				</tr>
			</table>
			
			
			<table id="module" class="list">
				<thead>
					<tr>
						<td class="left"><?php echo $entry_layout; ?></td>
						<td class="left"><?php echo $entry_position; ?></td>
						<td class="left"><?php echo $entry_status; ?></td>
						<td class="right"><?php echo $entry_sort_order; ?></td>
						<td></td>
					</tr>
				</thead>
				<?php $module_row = 0; ?>
				<?php foreach ($modules as $module) { ?>
				<tbody id="module-row<?php echo $module_row; ?>">
					<tr>
						<td class="left"><select name="we_menu_module[<?php echo $module_row; ?>][layout_id]">
								<?php foreach ($layouts as $layout) { ?>
								<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
								<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
								<?php } ?>
								<?php } ?>
							</select></td>
						<td class="left"><select name="we_menu_module[<?php echo $module_row; ?>][position]">
								<?php if ($module['position'] == 'content_top') { ?>
								<option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
								<?php } else { ?>
								<option value="content_top"><?php echo $text_content_top; ?></option>
								<?php } ?>
								<?php if ($module['position'] == 'content_bottom') { ?>
								<option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
								<?php } else { ?>
								<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
								<?php } ?>
								<?php if ($module['position'] == 'column_left') { ?>
								<option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
								<?php } else { ?>
								<option value="column_left"><?php echo $text_column_left; ?></option>
								<?php } ?>
								<?php if ($module['position'] == 'column_right') { ?>
								<option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
								<?php } else { ?>
								<option value="column_right"><?php echo $text_column_right; ?></option>
								<?php } ?>
							</select></td>
						<td class="left"><select name="we_menu_module[<?php echo $module_row; ?>][status]">
								<?php if ($module['status']) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select></td>
						<td class="right"><input type="text" name="we_menu_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
						<td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
					</tr>
				</tbody>
				<?php $module_row++; ?>
				<?php } ?>
				<tfoot>
					<tr>
						<td colspan="4"></td>
						<td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</div> -->

<script type="text/javascript"><!--

var menu_item_row = <?php echo !empty($we_menu) ? count($we_menu) : 0; ?>;

$('[data-toggle="tab"]').on('show.bs.tab', function (e) {
	if ($(e.target).attr('href') == '#tab-menu-item-add') {
		e.preventDefault();
		$tab = addMenuItem();
		$tab.find('a[data-toggle="tab"]').tab('show');
	}
});

$('.tab-content').delegate('.tab-pane .btn-danger', 'click', function (e) {
	e.preventDefault();
	var tabPane = $(this).closest('.tab-pane'),
		tabPaneId = tabPane.attr('id'),
		tabHandler = $('[data-toggle="tab"][href="#' + tabPaneId + '"]').closest('li');

	tabPane.remove();
	tabHandler.remove();
	
	$('[data-toggle="tab"]:first').tab('show');

}).delegate('.tab-pane .show-input-select', 'change', function (e) {
	var checked = $(this),
		tabPane = checked.closest('.tab-pane');

	if (typeof checked.data('show') !== 'undefined') {
		tabPane.find('.show-input-select-block').hide();
		$showBlock = $(checked.data('show')).show();
		
		if ($showBlock.find('.article-name').length)
			$showBlock.find('.article-name').trigger('change');
		else
			tabPane.find('.tab-handler-name').trigger('input');
	}
}).delegate('.tab-pane .tab-handler-name', 'input', function (e) {
	var input = $(this),
		name = input.val(),
		tabHandler = input.data('tab-handler');

	if (name)
		$(tabHandler).text(name);
	else
		$(tabHandler).text($(tabHandler).data('default-name'));
}).delegate('.tab-pane .article-name', 'change', function (e) {
	var select = $(this),
		tabPane = select.closest('.tab-pane'),
		name = tabPane.find('.tab-handler-name').val() ? tabPane.find('.tab-handler-name').val() : select.find('option:selected').text(),
		value = select.find('option:selected').val();
		tabHandler = select.data('tab-handler');

	if (name && value > 0)
		$(tabHandler).text(name);
	else
		$(tabHandler).text($(tabHandler).data('default-name'));
});

function addMenuItem(){
	var contentHtml = '',
		tabHtml = '',
		tabName = '<?php echo sprintf($text_item, "{{num}}"); ?>'.replace('{{num}}', menu_item_row + 1);

	tabHtml += '<li><a href="#tab-menu-item-' + menu_item_row + '" id="tab-menu-item-handler-' + menu_item_row + '" data-toggle="tab" data-default-name="' + tabName + '" aria-expanded="false">' + tabName + '</a></li>';

	contentHtml += '<div class="tab-pane active" id="tab-menu-item-' + menu_item_row + '">';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-' + menu_item_row + '"><?php echo $entry_item; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<input type="text" class="form-control tab-handler-name" data-tab-handler="#tab-menu-item-handler-' + menu_item_row + '" value="" name="we_menu[' + menu_item_row + '][item]" id="input-item-' + menu_item_row + '" placeholder="<?php echo $entry_item; ?>" />';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-' + menu_item_row + '"><?php echo $entry_item_type; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<label class="radio-inline"><input class="show-input-select" data-show="#informations-select-' + menu_item_row + '" type="radio" value="article_link" id="article_link' + menu_item_row + '" name="we_menu[' + menu_item_row + '][item_type]" id="article_link' + menu_item_row + '" /> <?php echo $text_article_link; ?></label>';
	contentHtml += '			<label class="radio-inline"><input class="show-input-select" data-show="#link-input-' + menu_item_row + '" type="radio" value="clear_link" name="we_menu[' + menu_item_row + '][item_type]" checked="checked" id="clear_link' + menu_item_row + '"/> <?php echo $text_clear_link; ?></label>';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" id="input-item-link-' + menu_item_row + '"><?php echo $entry_item_link ?></label>';
	contentHtml += '		<div class="col-sm-10 show-input-select-block" id="informations-select-' + menu_item_row + '" style="display:none;">';
	contentHtml += '			<select class="form-control article-name" name="we_menu[' + menu_item_row + '][information_id]" data-tab-handler="#tab-menu-item-handler-' + menu_item_row + '" id="input-item-information-' + menu_item_row + '">';
	contentHtml += '				<option value="0"><?php echo $text_select; ?></option>';
	
	<?php foreach($informations as $information) { ?>
	contentHtml += '				<option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>';
	<?php } ?>
	
	contentHtml += '			</select>';
	contentHtml += '		</div>';
	contentHtml += '		<div class="col-sm-10 show-input-select-block" id="link-input-' + menu_item_row + '" style="display:block;">';
	contentHtml += '			 <input type="text" class="form-control" value="" name="we_menu[' + menu_item_row + '][item_link]" id="input-item-link-' + menu_item_row + '" placeholder="<?php echo $entry_item_link ?>" />';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-class-' + menu_item_row + '"><?php echo $entry_item_class; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<input type="text" class="form-control" value="" name="we_menu[' + menu_item_row + '][class]" id="input-item-class-' + menu_item_row + '" placeholder="<?php echo $entry_item_class; ?>" />';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-attr-' + menu_item_row + '"><?php echo $entry_item_attr; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<input type="text" class="form-control" value="" name="we_menu[' + menu_item_row + '][attr]" id="input-item-attr-' + menu_item_row + '" placeholder="<?php echo $entry_item_attr; ?>" />';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-sort-' + menu_item_row + '"><?php echo $entry_item_sort; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<input type="text" class="form-control" value="" name="we_menu[' + menu_item_row + '][sort]" id="input-item-sort-' + menu_item_row + '" placeholder="<?php echo $entry_item_sort; ?>" />';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<label class="col-sm-2 control-label" for="input-item-enable-' + menu_item_row + '"><?php echo $entry_item_enable; ?></label>';
	contentHtml += '		<div class="col-sm-10">';
	contentHtml += '			<label class="radio-inline">';
	contentHtml += '				<input type="checkbox" class="form-control" value="1" name="we_menu[' + menu_item_row + '][item_enable]" id="input-item-enable-' + menu_item_row + '" checked="checked" />';
	contentHtml += '			</label>';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '	<div class="form-group">';
	contentHtml += '		<div class="col-sm-10 col-sm-offset-2">';
	contentHtml += '			<button type="button" class="btn btn-danger"><?php echo $button_remove; ?></button>';
	contentHtml += '		</div>';
	contentHtml += '	</div>';
	contentHtml += '</div>';

	$tabHtml = $(tabHtml);

	$('a[href="#tab-menu-item-add"]').parent().before($(tabHtml));
		
	$('.tab-content').append(contentHtml);

	menu_item_row++;

	return $tabHtml;
}

$('.nav.nav-pills').find('li:first').find('a').tab('show');
</script>

<?php echo $footer; ?>