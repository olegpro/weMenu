<?php
class ControllerModuleWeMenu extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/we_menu');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('we_menu', $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }
		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_article_link'] = $this->language->get('text_article_link');
        $data['text_clear_link'] = $this->language->get('text_clear_link');
        $data['text_select'] = $this->language->get('text_select');
        $data['text_item'] = $this->language->get('text_item');
		$data['text_edit'] = $this->language->get('text_edit');
		
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
        
        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_title'] = $this->language->get('entry_title');
        $data['entry_item'] = $this->language->get('entry_item');
        $data['entry_item_type'] = $this->language->get('entry_item_type');
        $data['entry_item_link'] = $this->language->get('entry_item_link');
        $data['entry_item_class'] = $this->language->get('entry_item_class');
        $data['entry_item_attr'] = $this->language->get('entry_item_attr');
        $data['entry_item_sort'] = $this->language->get('entry_item_sort');
        $data['entry_item_enable'] = $this->language->get('entry_item_enable');
        $data['entry_item_enable_y'] = $this->language->get('entry_item_enable_y');
        $data['entry_item_enable_n'] = $this->language->get('entry_item_enable_n');
        $data['entry_menu_class'] = $this->language->get('entry_menu_class');
        $data['entry_add'] = $this->language->get('entry_add');
        $data['entry_tpl_row'] = $this->language->get('entry_tpl_row');
        $data['entry_tpl_row_act'] = $this->language->get('entry_tpl_row_act');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_remove'] = $this->language->get('button_remove');
		
        
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }

        if (isset($this->error['item'])) {
            $data['error_item'] = $this->error['item'];
        } else {
            $data['error_item'] = array();
        }

        if (isset($this->error['information_id'])) {
            $data['error_information_id'] = $this->error['information_id'];
        } else {
            $data['error_information_id'] = array();
        }

        if (isset($this->error['link'])) {
            $data['error_link'] = $this->error['link'];
        } else {
            $data['error_link'] = array();
        }
				
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
   		);
		
        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('module/we_menu', 'token=' . $this->session->data['token'], 'SSL')
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('module/we_menu', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
            );
        }
		
        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('module/we_menu', 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('module/we_menu', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
        }
        
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $data['token'] = $this->session->data['token'];

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        $this->load->model('catalog/information');	
		$data['informations'] = $this->model_catalog_information->getInformations();			
			
        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (isset($module_info['name'])) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }

        if (isset($this->request->post['sort_order'])) {
            $data['sort_order'] = $this->request->post['sort_order'];
        } elseif (isset($module_info['sort_order'])) {
            $data['sort_order'] = $module_info['sort_order'];
        } else {
            $data['sort_order'] = '';
        }

        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (isset($module_info['status'])) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '';
        }

        if (isset($this->request->post['we_menu_class'])) {
            $data['we_menu_class'] = $this->request->post['we_menu_class'];
        } elseif (isset($module_info['we_menu_class'])) {
            $data['we_menu_class'] = $module_info['we_menu_class'];
        } else {
            $data['we_menu_class'] = '';
        }

        if (isset($this->request->post['tpl_row'])) {
            $data['tpl_row'] = $this->request->post['tpl_row'];
        } elseif (isset($module_info['tpl_row'])) {
            $data['tpl_row'] = $module_info['tpl_row'];
        } else {
            $data['tpl_row'] = $this->language->get('tpl_row');
        }

        if (isset($this->request->post['tpl_row_act'])) {
            $data['tpl_row_act'] = $this->request->post['tpl_row_act'];
        } elseif (isset($module_info['tpl_row_act'])) {
            $data['tpl_row_act'] = $module_info['tpl_row_act'];
        } else {
            $data['tpl_row_act'] = $this->language->get('tpl_row_act');
        }
        
        if (isset($this->request->post['we_menu'])) {
            $data['we_menu'] = $this->request->post['we_menu'];
        } elseif (isset($module_info['we_menu'])) {
            $data['we_menu'] = $module_info['we_menu'];
        } else {
            $data['we_menu'] = array();
        }
        
        $data['header'] = $this->load->controller('common/header');
		$data['footer'] = $this->load->controller('common/footer');
        $data['column_left'] = $this->load->controller('common/column_left');
				
		$this->response->setOutput($this->load->view('module/we_menu.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/we_menu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

        if (!$this->request->post['name']) {
            $this->error['name'] = $this->language->get('error_name');
        }
        
        if (isset($this->request->post['we_menu']) && !empty($this->request->post['we_menu'])){
            foreach ($this->request->post['we_menu'] as $i => $item) {
                if ($item['item_type'] == 'clear_link') {
                    if (!$item['item'])
                        $this->error['item'][$i] = $this->language->get('error_item');
                    
                    if (!$item['item_link'])
                        $this->error['link'][$i] = $this->language->get('error_link');
                }

                if ($item['item_type'] == 'article_link' && !(int)$item['information_id']) {
                    $this->error['information_id'][$i] = $this->language->get('error_information');
                }
            }
        } else {
            $this->error['warning'] = $this->language->get('error_empty_menu');
        }

		return !$this->error;
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

}
?>