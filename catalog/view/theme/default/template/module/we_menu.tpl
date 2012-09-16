<ul class="<?php echo $we_menu_class ?>">
<?php if(!empty($we_menu)){ ?>
    <?php foreach($we_menu as $item){ 
          $tpl = strpos($_SERVER['REQUEST_URI'], $item['href']) !== false ? 'tpl_row_act' : 'tpl_row';
          echo str_replace('&', '&amp;', html_entity_decode($item[$tpl]));
    } ?>
<?php } ?>
</ul>