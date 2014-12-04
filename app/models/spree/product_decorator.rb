Spree::Product.class_eval do

  def self.publish_from_mockbot(sku)
    if sku.nil?
      fail %(
        Please provide a sku, for example:
        `bundle exec rake mockbot:upload[some_product_sku]`
      )
    end

    Thread.current[:response] = Struct.new(:original_uri)
    .new(Spree::Store.default.first.domains.split(/\s/).first)

    begin
      idea = Spree::Mockbot::Idea.where(sku: sku).first
    rescue Errno::ECONNREFUSED
      fail %(
        MockBot connection refused. Is it down?
      )

    rescue ActiveResource::UnauthorizedAccess
      fail %(
        MockBot authorization ed. Go check out the authentication settings for MockBot
        in the Spree Admin.
      )
    rescue StandardError => e
      fail "Error while connecting to MockBot: #{e.message}"

    end
    if idea.nil?
      fail "Found no idea with sku #{sku}."

    end

    publisher = idea.publisher
    publisher.try(:destroy)

    publisher = Spree::Mockbot::Idea::Publisher
    .create(idea_sku: sku)

    begin
      publisher.do_everything!
    rescue Spree::Mockbot::Idea::PublishError => e
      fail %(
        Error during `#{publisher.current_step}` step: #{e.message}
           )

    rescue SpreeMockbotIntegration::Sku::SkuError => e
      fail %(
        Sku error during `#{publisher.current_step}` step: #{e.message}
           )

    end

    publisher.destroy

    puts %(
      Successfully published products for idea #{sku}!
    )
  end

end