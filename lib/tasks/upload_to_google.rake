namespace :product do
  desc %(
    Upload all variants of a product to Google Shopping. Argument
    can be a sku or an id of a product. This assumes the product
    is a t-shirt.
  )
  task :upload_to_google, [:id_or_sku, :email_errors] => :environment do |_t, args|
    args.with_defaults id_or_sku: nil, email_errors: nil

    if args.id_or_sku.nil?
      STDOUT.puts %(
        Please specify a product id or sku:
        `bundle exec rake product:upload_to_google[some_sku]`
      )
      next
    end

    include Spree::GoogleShoppingTasks

    on_error = args.email_errors == 'email' ? email_errors : print_errors
    upload_to_google(args.id_or_sku, on_error: on_error)
  end

  desc %(
    Upload every t-shirt product variant to Google Shopping.
    If there is no Spree::ShippingCategory with the name "T-shirt",
    this task will inform you via STDOUT and do nothing.
  )
  task :upload_all_to_google, [:email_errors] => :environment do |_t, args|
    args.with_defaults email_errors: nil

    include Spree::GoogleShoppingTasks

    on_error = args.email_errors == 'email' ? email_errors : print_errors
    upload_all_to_google(on_error: on_error)
  end

  desc %(
    Remove any google products that belong to variants whose sku
    has been changed.
  )
  task :remove_dangling_from_google, [:id_or_sku] => :environment do
    args.with_defaults id_or_sku: nil, email_errors: nil

    if args.id_or_sku.nil?
      STDOUT.puts %(
        Please specify a product id or sku:
        `bundle exec rake product:upload_to_google[some_sku]`
      )
      next
    end

    include Spree::GoogleShoppingTasks

    remove_dangling(args.id_or_sku)
  end
end
