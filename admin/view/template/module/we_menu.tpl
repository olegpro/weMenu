<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="formSubmitWe();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><?php echo $entry_menu_class ?></td>
          <td><input type="text" value="<?php echo $we_menu_class ?>" size="30" name="we_menu_class" /></td>
        </tr>
        <tr>
          <td><?php echo $entry_tpl_row ?></td>
          <td><textarea style="width: 450px;height: 40px;" name="tpl_row"><?php echo $tpl_row ?></textarea></td>
        </tr>
        <tr>
          <td><?php echo $entry_tpl_row_act ?></td>
          <td><textarea style="width: 450px;height: 40px;" name="tpl_row_act"><?php echo $tpl_row_act ?></textarea></td>
        </tr>
      </table>
      
      <pre><?php
	   //print_r($we_menu);
      ?></pre>
      
      <table id="" class="list menu_table">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_item ?></td>
            <td class="left"><?php echo $entry_item_type ?></td>
            <td class="left"><?php echo $entry_item_link ?></td>
            <td class="left"><?php echo $entry_item_class ?></td>
            <td class="left"><?php echo $entry_item_attr ?></td>
            <td class="left"><?php echo $entry_item_sort ?></td>
            <td class="left"><?php echo $entry_item_enable ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $first_i = reset($list_inforations); ?>
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
                    <?php if(!empty($list_inforations) && $item['item_type'] == 'article_link'){
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
</div>

<script type="text/javascript"><!--

var menu_item_row = <?php echo !empty($we_menu) ? count($we_menu) : 0; ?>;
var link_output = '';
 
<?php if(!empty($list_inforations)){ ?>

link_output += '<div class="item_link_box">';
link_output += '<input type="hidden" name="we_menu['+menu_item_row+'][item_link]" value="<?php echo $first_i['information_id'] ?>" />';
link_output += '<select name="articles" class="articles">';
<?php foreach($list_inforations as $i_item){ ?>
link_output += '<option value="<?php echo $i_item['information_id'] ?>"><?php echo $i_item['title'] ?></option>';
<?php } ?>
link_output += '</select>';
link_output += '</div>';
<?php }else{ ?>
link_output += '<input type="text" name="we_menu['+menu_item_row+'][item_link]" value="" />';
<?php } ?>

function addMenuItem(){
    var html = ['<tbody class="menu-row'+menu_item_row+'">'+
                    '<tr>'+
                        '<td class="left"><input type="text" value="" size="15" name="we_menu['+menu_item_row+'][item]"></td>'+
                        '<td class="left">'+
                            '<input type="radio" class="item_type" value="article_link" id="article_link'+menu_item_row+'" checked="checked" name="we_menu['+menu_item_row+'][item_type]" id="" /><label for="article_link'+menu_item_row+'">Ссылка на статью</label>'+
                            '<input type="radio" class="item_type" value="clear_link" id="clear_link'+menu_item_row+'" name="we_menu['+menu_item_row+'][item_type]" /><label for="clear_link'+menu_item_row+'">Обычная ссылка</label>'+
                        '</td>'+
                        '<td class="left">'+
                            link_output +
                        '</td>'+
                        '<td class="left"><input type="text" value="" size="10" name="we_menu['+menu_item_row+'][class]" /></td>'+
                        '<td class="left"><input type="text" value="" size="15" name="we_menu['+menu_item_row+'][attr]" /></td>'+
                        '<td class="left"><input type="text" value="'+menu_item_row+'" size="2" name="we_menu['+menu_item_row+'][sort]" /></td>'+
                        '<td class="left"><input type="checkbox" name="we_menu['+menu_item_row+'][item_enable]" checked="checked" /></td>'+
                        '<td class="left"><a onclick="$(\'.menu-row'+menu_item_row+'\').remove();" class="button"><?php echo $button_remove; ?></a></td>'+
                    '</tr>'+
                '</tbody>'].join('');
    
    $(html).insertBefore($('.menu_table tfoot'));
    menu_item_row++;
}

function formSubmitWe(){
    $(this).unbind();
    var error = [];
    
    $('.article_link').each(function(){
       var el = this;
       var art_link = $(el).find('input');
       if($(art_link).val().length == 0){
            $(art_link).css({'border':'1px solid red'});
            error.push('false');
       }
       
    });
    
       if(error.length > 0){
            alert('Поле «Ссылка» должно быть заполено у все пунктов меню!');
            return false;
       }else{
            $('#form').submit();
       }
//
}

$(document).ready(function(){
   $('.articles').live('change', function(){
        var el = this;
        $(el)
            .parent()
            .find('input[type=hidden]')
            .val($(el).val());
   });
   
   
   $('.item_type').live('change', function(){
        var el = this;
        var item_link_box = $(el).parents('tbody').find('.item_link_box');
        var article_link = $(el).parents('tbody').find('.article_link');
        
        if(/clear_link/gi.test($(el).attr('id'))){
            $(item_link_box).hide();
            $('<div>', {
                'class' : 'article_link'
            }).append($('<input>', {
               'name'  : $(item_link_box).find('input[type=hidden]').attr('name'),
               'type'  : 'text',
               'size'  : '40',
               'value' : '' 
            })).insertAfter($(item_link_box));
        }else{
            $(item_link_box).show();
            $(article_link).remove();
        }
   });
});


//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	//html += '    <td class="left"><input type="text" name="we_menu_module[' + module_row + '][image_width]" value="80" size="3" /> <input type="text" name="we_menu_module[' + module_row + '][image_height]" value="80" size="3" /></td>';	
	html += '    <td class="left"><select name="we_menu_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="we_menu_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="we_menu_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="we_menu_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script> 
<?php echo $footer; ?>