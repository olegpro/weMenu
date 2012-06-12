<ul class="<?php echo $we_menu_class ?>">
<?php if(!empty($we_menu)){ ?>
    <?php foreach($we_menu as $item){ 
          $tpl = strpos($item['href'], $_SERVER['REQUEST_URI']) ? 'tpl_row_act' : 'tpl_row';
          echo html_entity_decode($item[$tpl]); 
    } ?>
<?php } ?>
</ul>