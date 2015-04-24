Spree::Shipment.class_eval do

  def self.ship_digital_orders
    digital_shipping_methods = Spree::ShippingMethod.where(name: 'Digital Download')
    digital_shipping_methods.each do |sm|
      shipments = Spree::Shipment.joins(:shipping_rates).where(spree_shipping_rates: {shipping_method_id: sm.id})
      shipments.each do |s|
        shipment = Spree::Shipment.find(s.id)
        shipment.ship
      end
    end
  end

end