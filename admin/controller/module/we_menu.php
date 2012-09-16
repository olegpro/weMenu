<?php
class ControllerModuleWeMenu extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/we_menu');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            
            $post = $this->request->post;
            if(isset($post['articles'])){
                $post['articles'] = null; unset($post['articles']);
            }
            
            //$menu = $this->cache->get('menu');
            $menuItems = array();
            
            if(isset($post['we_menu'])){
                $menu = $post['we_menu'];
                if(!empty($menu)){
                   usort($menu,  array(__CLASS__, "we_sort"));
                   
                   $count = 0;
                   foreach($menu as $item){
                    if(isset($item['item_enable'])){
                        $href =  $item['item_type'] == 'article_link' ? $this->getFullUrlInformation($item['item_link']) : $item['item_link'];
                        $href = preg_replace('/admin\//', '', $href);
                        
                        $fields = array(
                            'title'         => $item['item'],
                            'class'         => $item['class'],
                            'attributes'    => $item['attr'],
                            'href'          => $href
                        );
                        $menuItems[$count]['tpl_row']     = $this->my_parse_tpl($this->config->get('tpl_row'), $fields);
                        $menuItems[$count]['tpl_row_act'] = $this->my_parse_tpl($this->config->get('tpl_row_act'), $fields);
                        $menuItems[$count++]['href']      = $href;
                     }
                   }
                }
            }
            
            //$this->cache->set('we_menu', $menuItems);
            
			$this->model_setting_setting->editSetting('we_menu', array_merge($post, array('we_menu_cache' => $menuItems)));
            //$this->model_setting_setting->editSetting('we_menu', $post);
            		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        
        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_item'] = $this->language->get('entry_item');
        $this->data['entry_item_type'] = $this->language->get('entry_item_type');
        $this->data['entry_item_link'] = $this->language->get('entry_item_link');
        $this->data['entry_item_class'] = $this->language->get('entry_item_class');
        $this->data['entry_item_attr'] = $this->language->get('entry_item_attr');
        $this->data['entry_item_sort'] = $this->language->get('entry_item_sort');
        $this->data['entry_item_enable'] = $this->language->get('entry_item_enable');
        $this->data['entry_item_enable_y'] = $this->language->get('entry_item_enable_y');
        $this->data['entry_item_enable_n'] = $this->language->get('entry_item_enable_n');
        $this->data['entry_menu_class'] = $this->language->get('entry_menu_class');
        $this->data['entry_add'] = $this->language->get('entry_add');
        $this->data['entry_tpl_row'] = $this->language->get('entry_tpl_row');
        $this->data['entry_tpl_row_act'] = $this->language->get('entry_tpl_row_act');
        //$this->data['tpl_row'] = $this->language->get('tpl_row');
        //$this->data['tpl_row_act'] = $this->language->get('tpl_row_act');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
        
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
			'href'      => $this->url->link('module/we_menu', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/we_menu', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		
        $this->load->model('catalog/information');	
		$this->data['list_inforations'] = $this->model_catalog_information->getInformations();		
			
			
		$this->data['modules'] = array();
		
		if (isset($this->request->post['we_menu_module'])) {
			$this->data['modules'] = $this->request->post['we_menu_module'];
		} elseif ($this->config->get('we_menu_module')) { 
			$this->data['modules'] = $this->config->get('we_menu_module');
		}		
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
        
        if (isset($this->request->post['we_menu_class'])) {
			$this->data['we_menu_class'] = $this->request->post['we_menu_class'];
		} else {
			$this->data['we_menu_class'] = $this->config->get('we_menu_class');
		}
        
        if (isset($this->request->post['tpl_row'])) {
			$this->data['tpl_row'] = $this->request->post['tpl_row'];
		} else {
		    $tpl_row = $this->config->get('tpl_row');
			$this->data['tpl_row'] = !empty($tpl_row) ? $tpl_row : $this->language->get('tpl_row');
		}
        
        if (isset($this->request->post['tpl_row_act'])) {
			$this->data['tpl_row_act'] = $this->request->post['tpl_row_act'];
		} else {
            $tpl_row_act = $this->config->get('tpl_row_act');
			$this->data['tpl_row_act'] = !empty($tpl_row_act) ? $tpl_row_act : $this->language->get('tpl_row_act');
		}
        
        $this->data['we_menu'] = array();
        $cfg_menu = $this->config->get('we_menu');
        if(!empty($cfg_menu)){
            $this->data['we_menu'] = $cfg_menu;
        }
        

		$this->template = 'module/we_menu.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/we_menu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        
        if(isset($this->request->post['menu_module']) && !empty($this->request->post['menu_module'])){
            foreach ($this->request->post['menu_module'] as $key => $value) {
                
            }
        }
        
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
    
    private function getFullUrlInformation($information_id){
        //$full_url = $this->url->link('information/information', 'information_id='.$information_id);
        $full_url = '/index.php?route=information/information&information_id='.$information_id;
        
        if($this->config->get('config_seo_url')){
            if ($seo_type = $this->config->get('config_seo_url_type')) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'information_id=" . $this->db->escape($information_id) . "'");
                if ($query->num_rows) {
                    $full_url = '/'.$query->row['keyword'].'/';
                    
                    if($seo_type == 'seo_pro'){
            	       if($url_postfix = $this->config->get('config_seo_url_postfix')){
                	       $full_url = '/'.$query->row['keyword'] . $url_postfix;
                	   }
                	}
                }
            }
        }
        
        return $full_url;
    }
    
    private function my_parse_tpl($tpl, $params){
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