## weMenu
======

Модуль для Opencart 2.x

## Использование

Можно использовать как отдельный модуль, а так же можно выводить в шаблоне где угодно указав id модуля

```php
echo $this->registry->get('load')->controller('module/we_menu', array('module_id' => 34));
```php