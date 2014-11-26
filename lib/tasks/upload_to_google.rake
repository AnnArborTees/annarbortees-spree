namespace :product do
  desc %(
    Upload all variants of a product to Google Shopping. Argument
    can be a sku or an id of a product. This assumes the product
    is a t-shirt.
  )
  task :upload_to_google, [:id_or_sku] => :environment do |t, args|
    args.with_defaults id_or_sku: nil

    if args.id_or_sku.nil?
      puts %(
        Please specify an id or sku: `bundle exec rake product:upload_to_google[some_product_sku]`
        or `bundle exec rake product:upload_to_google[201]`
      )
      next
    end

    google_utils = Class.new { extend Spree::GoogleShoppingResponses }

    # This is conforming to my 'link' attribute hack, which requires
    # some kind of domain obviously. Check out the google_shopping.rb
    # initializer for more info.
    Thread.current[:response] = Struct.new(:original_uri)
      .new(Spree::Store.default.first.domains.split(/\s/).first)

    product = Spree::Product.where(id: args.id_or_sku).first ||
      Spree::Product.includes(:master).where(spree_variants: {is_master: true, sku: args.id_or_sku}).first

    if product.nil?
      puts "Couldn't find a product with id or sku #{args.id_or_sku}"
      next
    end

    product.master.google_product ||= Spree::GoogleProduct.create

    t_shirt_category = 
      'Apparel & Accessories > Clothing > Shirts & Tops > T-Shirts'

    master_product = product.master.google_product
    master_product.google_product_category = t_shirt_category
    master_product.save!
    
    if product.variants.any?
      product.variants.each do |variant|
        google_product = variant.google_product ||
          Spree::GoogleProduct.new(variant_id: variant.id)

        google_product.google_product_category = t_shirt_category
        google_product.automatically_update = true
        google_product.save!

        response = google_product.google_insert
        errors = google_utils.errors_from(response)
        if errors
          puts "****Errors on variant #{variant.sku}: ****"
          errors.each do |error|
            puts error
          end
        else
          puts "****No errors for variant #{variant.sku}!****"
        end
        puts "==================================================="
      end
    else
      response = master_product.google_insert
      errors = google_utils.errors_from(response)
      if errors
        puts errors
      else
        puts "Successfully uploaded product #{args.id_or_sku}"
      end
        puts "==================================================="
    end
  end
end
