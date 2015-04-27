PUBLISH_EVERY = 10.minutes


def log_time_and_memory(message)
  Rails.logger.error("#{Time.now} #{message}")
  output =  `mpstat -P ALL` rescue 'mpstat does not exist'
  unless output == 'mpstat does not exist' or output.nil?
    output.split('\n').each do |x|
      Rails.logger.error("#{Time.now} [publish_from_mockbot] #{x}")
    end
  end
end

unless defined?(Rails::Console)
  Thread.new do
    log_time_and_memory("[publish_from_mockbot] Starting Loop")
    loop do
      begin
        page = 1

        log_time_and_memory("[publish_from_mockbot] finding ideas for page #{page}")
        ideas = Spree::Mockbot::Idea.ready_to_publish(page)
        log_time_and_memory("[publish_from_mockbot] finding ideas for page #{page} done}")


        until ideas.empty? or ideas.nil?
          ideas.each do |idea|
            if idea.status == 'ready_to_publish'
              Rails.logger.error ("Publishing #{idea.sku}")
              begin

                log_time_and_memory("[publish_from_mockbot] marking queued to publish #{page} }")
                idea.update_attributes(
                    status: 'queued_to_publish'
                )
                log_time_and_memory("[publish_from_mockbot] marking queued to publish #{page} done")

                log_time_and_memory("[publish_from_mockbot] queuing to sidekiq")
                Spree::Product.delay.publish_from_mockbot(idea.sku)
                log_time_and_memory("[publish_from_mockbot] queuing to sidekiq done")

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
          log_time_and_memory("[publish_from_mockbot] finding ideas for page #{page}")
          ideas = Spree::Mockbot::Idea.ready_to_publish(page)
          log_time_and_memory("[publish_from_mockbot] finding ideas for page #{page} done}")
        end

        ActiveRecord::Base.clear_active_connections!

        log_time_and_memory("[publish_from_mockbot] Nap time")
        sleep PUBLISH_EVERY
        log_time_and_memory("[publish_from_mockbot] Just woke up from the nap")
      rescue Exception => e
        Rails.logger.error "[publish_from_mockbot] ERROR #{e} was thrown while importing products. Trying again in 10 minutes."
        e.backtrace.each(&Rails.logger.method(:error))
        ActiveRecord::Base.clear_active_connections!
        sleep PUBLISH_EVERY
        Rails.logger.error "[publish_from_mockbot] ERROR Waking up"
      end
    end
  end
end
