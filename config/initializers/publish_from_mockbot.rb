PUBLISH_EVERY = 10.minutes
unless defined?(Rails::Console)
  Thread.new do

    load "#{Rails.root}/app/models/spree/shipment_decorator.rb"
    loop do
      begin
        page = 1
        ideas = Spree::Mockbot::Idea.all(params: {page: page})
        until ideas.empty?
          ideas.each do |idea|
            if idea.status == 'ready_to_publish'
              logger.error ("Publishing #{idea.sku}")
              begin
                idea.update_attributes(
                    status: 'queued_to_publish'
                )
                Spree::Product.delay.publish_from_mockbot(idea.sku)
              rescue Exception => e
                idea.update_attributes(
                    status: 'failed_to_publish'
                )
                Rails.logger.error "URGENT: #{e} was thrown while importing product #{idea.sku}."
                e.backtrace.each(&Rails.logger.method(:error))
              end
            end
          end
          page += 1
          ideas = Spree::Mockbot::Idea.all(params: {page: page})
        end
        ActiveRecord::Base.clear_active_connections!
        sleep PUBLISH_EVERY
      rescue Exception => e
        Rails.logger.error "URGENT: #{e} was thrown while importing products. Trying again in 1 minute."
        e.backtrace.each(&Rails.logger.method(:error))
        ActiveRecord::Base.clear_active_connections!
        sleep PUBLISH_EVERY
        Rails.logger.error "URGENT: 1 minute has passed, trying again..."
      end
    end
  end
end
