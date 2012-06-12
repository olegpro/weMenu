<?php
class ControllerModuleWeMenu extends Controller{
    
    protected function index($setting){

        $this->data['we_menu_class'] = $this->config->get('we_menu_class');
        $we_menu = $this->config->get('we_menu_cache');
        $this->data['we_menu'] = $we_menu ? $we_menu : array();
        

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/we_menu.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/we_menu.tpl';
        } else {
            $this->template = 'default/template/module/we_menu.tpl';
        }
        
        $this->render();
    }
    
}
?>