<?php
class ControllerModuleWeMenu extends Controller {
    
    public function index($setting) {

        if (isset($setting['module_id'])) {
            $this->load->model('extension/module');
            $module_info = $this->model_extension_module->getModule($setting['module_id']);
        } else {
            $module_info = $setting;
        }

        $data['we_menu_class'] = $module_info['we_menu_class'];
        $data['we_menu']       = array();
        $we_menu = $module_info['we_menu'];

        $this->load->model('catalog/information');

        usort($we_menu, array(__CLASS__, 'we_sort'));

        foreach ($we_menu as &$item) {

            $name = $item['item'];
            $href = $item['item_link'];

            if ($item['item_type'] == 'article_link') {
                if (!(int)$item['information_id'])
                    continue;

                if (!$information_info = $this->model_catalog_information->getInformation($item['information_id']))
                    continue;

                $href = $this->url->link('information/information', 'information_id=' . $item['information_id']);
                
                if (!$name) {
                    $name = $information_info['title'];
                }
            }

            $item['data'] = array(
                'href'          => $href,
                'class'         => $item['class'],
                'attributes'    => $item['attr'],
                'title'         => $name,
            );

            $data['we_menu'][] = array(
                'href'          => $item['data']['href'],
                'tpl_row_act'   => $this->parse_tpl($module_info['tpl_row_act'], $item['data']),
                'tpl_row'       => $this->parse_tpl($module_info['tpl_row'], $item['data'])
            );
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/we_menu.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/module/we_menu.tpl', $data);
        } else {
            return $this->load->view('default/template/module/we_menu.tpl', $data);
        }

    }
   
    private function parse_tpl($tpl, $params){
        foreach ($params as $key => $val) {
            $tpl = str_replace("#$key#", $val, $tpl);
        }
        return $tpl;
    }

    private static function we_sort($v1, $v2){
        if ($v1['sort'] == $v2['sort']) {
            return 0;
        }
        return ($v1['sort'] < $v2['sort']) ? -1 : 1;
    }
}
?>