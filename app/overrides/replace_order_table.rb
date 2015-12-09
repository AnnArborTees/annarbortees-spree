Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
                     :name => 'replace_orders_table',
                     :replace => "#listing_orders",
                     :partial => 'spree/admin/orders/table',
                     :disabled => false )

Deface::Override.new(:virtual_path => 'spree/admin/orders/index',
                     :name => 'add_export_state_filter',
                     :insert_before => ".filter-actions",
                     :text => %q(
<div class="field">
  <%= label_tag nil, Spree.t(:export_state) %>
  <%= f.select :export_state_eq, Spree::Order.state_machines[:export_state].states.collect {|s| [Spree.t("order_state.#{s.name}"), s.value]}, {:include_blank => true}, :class => 'select2' %>
</div>
),
                     :disabled => false )

Deface::Override.new(:virtual_path => 'spree/admin/shared/_order_summary',
                     :name => 'add_export_sate_to_order_summary',
                     :insert_before => "[data-hook='admin_order_tab_subtotal_title']",
                     :text => %q(
<dt id="order_export-state" data-hook><%= Spree.t(:export_state) %>:</dt>
<dd><span class="state <%= @order.export_state %>"><%= Spree.t(@order.export_state, :scope => :export_state) %></span></dd>
),
                     :disabled => false )

Deface::Override.new(:virtual_path => 'spree/admin/shared/_order_summary',
                     :name => 'add_customer_details_to_order_summary',
                     :insert_before => "[data-hook='admin_order_tab_subtotal_title']",
                     :text => %q(
<dt id="order_bill_to_name" data-hook><%= Spree.t(:bill_to_name) %>:</dt>
<dd><%= @order.bill_address.full_name %></dd>
<dt id="order_ship_to_name" data-hook><%= Spree.t(:ship_to_name) %>:</dt>
<dd><%= @order.ship_address.full_name %></dd>
),
                     :disabled => false )



