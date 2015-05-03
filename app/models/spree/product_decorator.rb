Spree::Product.class_eval do
  # NOTE These analytics_ methods are called by multidomain for Google Analytics.
  def analytics_category
    property('product-type')
  end

  def analytics_brand
    'Ann Arbor Tees'
  end

  searchable if: :indexable? do
    text :meta_keywords
    text :meta_description
    text :apparel_color
  end

  def apparel_color
    # NOTE assumes all variants have the same apparel-color value.
    utils = Class.new { extend Spree::OptionValueUtils }
    return unless option_types.include?(utils.color_type)

    variants.find_each do |variant|
      relation = variant.option_values.where(option_type_id: utils.color_type.id)
      if relation.exists?
        return relation.first.presentation
      end
    end
    nil
  end

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

    idea.update_attributes(
        status: 'queued_to_publish'
    )

    publisher = idea.publisher
    publisher.try(:destroy)

    publisher = Spree::Mockbot::Idea::Publisher
    .create(idea_sku: sku)

    begin
      publisher.do_everything!
    rescue Spree::Mockbot::Idea::PublishError => e
      idea.update_attributes(
          status: 'failed_to_publish'
      )
      fail %(
        Error during `#{publisher.current_step}` step: #{e.message},
        #{e.backtrace}
      )


    rescue SpreeMockbotIntegration::Sku::SkuError => e
      fail %(
        Sku error during `#{publisher.current_step}` step: #{e.message}

        )
        idea.update_attributes(
            status: 'failed_to_publish'
        )
    end

    publisher.destroy

    puts %(
      Successfully published products for idea #{sku}!
    )
  end

end
