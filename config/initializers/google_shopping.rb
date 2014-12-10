def from_option_type(type_name, &block)
  proc do |variant|
    option_type = Spree::OptionType.where(name: type_name).first
    next if option_type.nil?
    result =
      variant.option_values.where(option_type_id: option_type.id)
        .first
        .try(:presentation)

    block ? block.call(result) : result
  end
end

def images_for(variant, conditions, optionals = {})
  logger = variant.send(:logger)

  optional = optionals[:optional] || []

  images = variant.images.where(conditions)
  images = variant.product.images.where(conditions) if images.empty?
  # logger.error "Images for #{variant.sku}: none for initial conditions: #{conditions}" if images.empty?

  until optional.empty? || images.any?
    conditions.delete(optional.pop)

    images = variant.images.where(conditions)
    images = variant.product.images.where(conditions) if images.empty?

    # logger.error "Images for #{variant.sku}: none for conditions #{conditions}"
  end
  # logger.error "Images for #{variant.sku}: Calling it quits with #{images.map { |i| i.attachment.url(:original) }}"

  images
end

# These settings are how we control how product variant data is sent
# to Google. It is recommended you look over all of these, and change
# most of them to fit your specific needs.
Spree::GoogleProduct.configure do |config|
  # The following define offer_id, title, and description fields to come
  # from the variant's name, sku, and description fields respectively.
  config.define.offer_id(&:sku)
  config.define.title(&:name)
  config.define.description(&:description)

  # This defines the google_product_category field as a configurable
  # field of Spree::GoogleProduct. If you add as_db_column defines,
  # you will need to create your own migrations to add the fields.
  # User added fields will be automatically added to the admin views
  # for Google Products.
  #
  # Not passing a block will default to { |f, n| f.text_field(n) }
  config.define.google_product_category.as_db_column do |f|
    categories = Net::HTTP.get(
      URI 'http://www.google.com/basepages/producttype/taxonomy.en-US.txt'
    )
      .split("\n")[1..-1]

    f.collection_select(
      :google_product_category,
      categories, :to_s, :to_s,
      { include_blank: 'Valid Product Categories' },
      { class: 'select2-min-len-4' }
    )
  end

  # This grabs the url to the product the variant represents for the
  # link field. During an insert, the view/controller context is also
  # passed to these methods in order to provide access to url helpers.
  # It is an optional parameter, however, so make sure it's not nil
  # before using it.
  #
  # config.define.link do |variant, view|
  #   view.try(:product_url, variant.product)
  # end

  config.define.link do |variant|
    store = variant.product.stores.first
    next if store.nil?

    url = store.domains.split(/\s/).first
    next if url.nil? || url.empty?

    "http://#{url}/products/#{variant.product.slug}"
  end

  # NOTE: It is recommended you implement your own definition for
  # image_link and additional_image_link, so as to conform to
  # Google's specifications:
  # https://support.google.com/merchants/answer/188494
  #
  # config.define.image_link do |variant|
  #   variant.images[1..-1].map(&:url).to_json if variant.images[1..-1]
  # end

  config.define.condition.as_db_column(default: 'new') do |f|
    f.select :condition, %w(new used refurbished), {}, class: 'select2'
  end
  config.define.adult.as_db_column { |f| f.check_box(:adult) }

  # Availability will never change with this setting:
  config.define.availability 'in stock'

  config.define.channel 'online'
  config.define.content_language 'en'
  config.define.target_country 'US'

  # Struct fields can be defined as hashes.
  config.define.price do |variant|
    {
      value: variant.price.to_s,
      currency: variant.currency
    }
  end

  config.define.item_group_id do |variant|
    variant.is_master? ? nil : variant.product_id
  end

  config.define.brand 'Ann Arbor Tees'
  config.define.color(&from_option_type('apparel-color'))
  config.define.sizes(&from_option_type('apparel-size') { |s| [s] })
  config.define.size_type 'Regular'
  config.define.size_system 'US'
  config.define.gender(&from_option_type('apparel-style') do |style|
    case style.try(:presentation).try(:downcase)
    when 'unisex', 'ladies' then style.presentation
    else 'unisex'
    end
  end)

  config.define.size_type.as_db_column(default: 'regular') do |f|
    choices = ['Regular', 'Petite', 'Plus', 'Big and Tall', 'Maternity']
      .map { |c| [c, c.downcase] }

    f.select :size_type, choices, {}, class: 'select2'
  end
  config.define.age_group.as_db_column(default: 'adult') do |f|
    choices = [
      ['Newborn (0-3 months)', 'newborn'],
      ['Infant (3-12 months)', 'infant'],
      ['Toddler (1-5 years)', 'toddler'],
      ['Kids (5-13 years)', 'kids'],
      ['Adult (13+ years)', 'adult']
    ]

    f.select :age_group, choices, {}, class: 'select2'
  end

  config.define.shipping_weight do |variant|
    {
      unit: 'ounces',
      value: variant.weight.to_s
    }
  end
  config.define.shipping do |_variant|
    price_for = {
      'US' => '2.99',
      'CA' => '7.99'
    }
    price_for.default = '11.99'


    %w(US CA AU FR UK DE).map do |country|
      {
        country: country,
        price: {
          currency: 'USD',
          value: price_for[country]
        }
      }
    end
  end

  config.define.image_link do |variant|
    # Note that this relies on products representing one color each:
    conditions = {
      thumbnail: true,
      option_value_id: variant.option_values.map(&:id)
    }

    image = images_for(variant, conditions, optional: [:option_value_id]).first
    next if image.nil?
    image_url = image.attachment.url(:original)

    # HACK? The variant object passed to all these blocks is the
    # same, so we can share info between these calls through
    # instance variables. This relies on the call order though,
    # which is the order of GoogleProduct.G_ATTRIBUTES.
    variant.instance_variable_set(:@google_image_url, image_url)
    image_url
  end

  config.define.additional_image_link do |variant|
    first_image_url = variant.instance_variable_get(:@google_image_url)
    next if first_image_url.nil?

    conditions = {
      thumbnail: true,
      option_value_id: variant.option_values.map(&:id)
    }
    images     = images_for(variant, conditions, optional: [:option_value_id])
    image_urls = images.map { |i| i.attachment.url(:original) }

    image_urls - [first_image_url]
  end

  config.define.product_type.as_db_column(default: 'T-Shirt')
end
