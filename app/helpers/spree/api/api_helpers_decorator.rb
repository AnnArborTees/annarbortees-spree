Spree::Api::ApiHelpers.class_eval do
  @@order_attributes = [
      :id, :number, :item_total, :total, :ship_total, :state, :export_state, :adjustment_total,
      :user_id, :created_at, :updated_at, :completed_at, :payment_total,
      :shipment_state, :payment_state, :email, :special_instructions, :channel,
      :included_tax_total, :additional_tax_total, :display_included_tax_total,
      :display_additional_tax_total, :tax_total, :currency, :considered_risky
  ]
end