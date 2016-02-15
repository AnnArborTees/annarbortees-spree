Spree::Shipment.class_eval do

  def self.ship_digital_orders
    errors = []
    digital_shipping_methods = Spree::ShippingMethod.where(name: 'Digital Download')
    digital_shipping_methods.each do |sm|
      shipments = Spree::Shipment.joins(:shipping_rates).where(spree_shipping_rates: {shipping_method_id: sm.id}, state: 'ready')
      shipments.each do |s|
        shipment = Spree::Shipment.find(s.id) # reload because of above joins
        begin
          shipment.ship
        rescue StateMachine::InvalidTransition => e
         shipment.update_attribute(:state, :shipped)
         shipment.order.update_attribute(:shipment_state, :shipped)
        rescue ActionView::Template::Error =>  e
         shipment.update_attribute(:state, :shipped)
         shipment.order.update_attribute(:shipment_state, :shipped)
        end
      end
    end

    unless errors.empty?
      raise Exception, errors.join(", ")
    end
  end

end
