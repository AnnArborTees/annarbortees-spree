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
<dd><span class="state <%= export_state_class(@order.export_state) %> <%= @order.export_state %>"><%= Spree.t(@order.export_state, :scope => :export_state) %></span></dd>
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

Deface::Override.new(
  virtual_path: 'spree/admin/orders/_add_product',
  name: 'add_resolve_fraud_button_to_order_edit',
  insert_before: "#add-line-item",
  text: %q(
  <% if @order.fraudulent? %>
    <fieldset class='no-border-bottom'>
      <legend align='center'>Fraud Protection</legend>

      <% if @order.fraudulent_pp_ref.present? %>
        <ul>
        <% @order.fraudulent_pp_refs.each do |pp_ref| %>
          <li><%= pp_ref %></li>
        <% end %>
        </ul>
      <% end %>

      <%= button_to "/admin/orders/#{@order.number}/resolve_fraud", method: :post, class: 'button', data: { confirm: "Allow this order to be exported and processed?" } do %>
        <i class='fa fa-shield'></i> Payment Went Through
      <% end %>
      <%= button_to "/admin/orders/#{@order.number}/cancel", method: :post, class: 'button', data: { confirm: "Cancel this order?" } do %>
        <i class='fa fa-cancel'></i> Cancel Order
      <% end %>
    </fieldset>
  <% end %>
),
  disabled: false
)

