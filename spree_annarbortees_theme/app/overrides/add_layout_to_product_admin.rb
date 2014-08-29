Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
                     :name => 'layouts_for_product',
                     :insert_after => "[data-hook='admin_product_form_tax_category']",
                     :partial => 'spree/admin/products/layout_select',
                     :disabled => false )