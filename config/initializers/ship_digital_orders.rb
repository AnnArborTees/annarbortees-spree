SHIP_EVERY = 1.minute
unless defined?(Rails::Console) || Rails.env.development?
  Thread.new do

    load "#{Rails.root}/app/models/spree/shipment_decorator.rb"
    loop do
      begin
        Spree::Shipment.ship_digital_orders
        ActiveRecord::Base.clear_active_connections!
        sleep SHIP_EVERY
      rescue Exception => e
        Rails.logger.error "URGENT: #{e} was thrown while shipping digital downloads. Trying again in 1 minute."
        e.backtrace.each(&Rails.logger.method(:error))
        ActiveRecord::Base.clear_active_connections!
        sleep SHIP_EVERY
        Rails.logger.error "Spree Digital Shipment Failure::: 1 minute has passed, trying again..."
      end
    end
  end
end
