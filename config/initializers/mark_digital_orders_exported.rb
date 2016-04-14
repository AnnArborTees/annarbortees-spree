MARK_EXPORTED_EVERY = 1.minute
unless defined?(Rails::Console) || Rails.env.development?
  Thread.new do

    load "#{Rails.root}/app/models/spree/shipment_decorator.rb"
    loop do
      begin
        orders = Spree::Order.where.not(completed_at: nil).where(export_state: 'pending')
        orders.each do |order|
          shipments = order.shipments.map{|x| x.shipping_method.name }.uniq
          begin
          order.digital_only if shipments == ['Digital Download']
          rescue
            order.update_column :export_state, 'digital_only' if shipments == ['Digital Download']
          end
        end
        sleep MARK_EXPORTED_EVERY
      rescue Exception => e
        Rails.logger.error "URGENT: #{e} was thrown while marking digital downloads. Trying again in 1 minute."
        e.backtrace.each(&Rails.logger.method(:error))
        ActiveRecord::Base.clear_active_connections!
        sleep SHIP_EVERY
        Rails.logger.error "Marking Digital Download Failures::: 1 minute has passed, trying again..."
      end
    end
  end
end
