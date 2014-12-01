namespace :mockbot do
  desc %(Publish a product from MockBot with the given sku.)
  task :publish, [:sku] => :environment do |t, args|
    args.with_defaults sku: nil
    sku = args.sku

    if sku.nil?
      STDOUT.puts %(
        Please provide a sku, for example:
        `bundle exec rake mockbot:upload[some_product_sku]`
      )
      next
    end

    Thread.current[:response] = Struct.new(:original_uri)
      .new(Spree::Store.default.first.domains.split(/\s/).first)

    begin
      idea = Spree::Mockbot::Idea.where(sku: sku).first
    rescue Errno::ECONNREFUSED
      STDOUT.puts %(
        MockBot connection refused. Is it down?
      )
      next
    rescue ActiveResource::UnauthorizedAccess
      STDOUT.puts %(
        MockBot authorization failed. Go check out the authentication settings for MockBot
        in the Spree Admin.
      )
      next
    rescue StandardError => e
      STDOUT.puts "Error while connecting to MockBot: #{e.message}"
      next
    end
    if idea.nil?
      STDOUT.puts "Found no idea with sku #{sku}."
      next
    end

    publisher = idea.publisher
    publisher.try(:destroy)

    publisher = Spree::Mockbot::Idea::Publisher
                .create(idea_sku: sku)

    begin
      publisher.do_everything!
    rescue Spree::Mockbot::Idea::PublishError => e
      STDOUT.puts %(
        Error during `#{publisher.current_step}` step: #{e.message}
      )
      next
    rescue SpreeMockbotIntegration::Sku::SkuError => e
      STDOUT.puts %(
        Sku error during `#{publisher.current_step}` step: #{e.message}
      )
      next
    end

    publisher.destroy

    STDOUT.puts %(
      Successfully published products for idea #{sku}!
    )
  end
end
