namespace :qa do

  desc 'QA Shipping Methods'
  task shipping_methods: :environment do
    Spree::ShippingMethod.all.each do |sm|
      puts "[QA Shipping Method Fail] Shipping Method - '#{sm.name}'" if sm.name.blank? or sm.admin_name.blank? or sm.tracking_url.blank?
    end
  end


  desc 'Price products at their lowest variant price'
  task reprice_products: :environment do
    Spree::Product.all.each do |product|
      next if product.variants.empty?
      price = product.variants.min{ |a, b| a.price <=> b.price }.price
      if product.price < price
        puts "[REPRICING] Product #{product.name} priced at #{product.price} should be #{price}"
        product.price = price
        product.save
      end
    end
  end

  desc 'QA Products'
  task products: :environment do
    failures = []

    Spree::Product.all.each do |product|
      (failures <<  "[QA images Fail] Product '#{product.name}'")  if !product.available_on.blank? && product.images.empty?

      if product.layout == 'imprinted_apparel' and !product.available_on.blank?
        product.variants.each do |v|
          begin
            (failures <<  "[QA weight Fail] Product '#{product.name}' - '#{v.sku}'") if v.weight < 0.1
            (failures << "[QA SKU Fail] Product '#{product.name}' - '#{v.sku}'") if v.sku.split('-')[2].size != 10
            (failures << "[QA track_inventory Fail] Product - '#{v.sku}'") if v.track_inventory?
          rescue Exception => e
            failures <<  "[QA Exception Fail] Product '#{product.name}' - '#{v.sku}' - Exception #{e}"
          end
        end
      elsif product.layout == 'digital_download'
        product.variants.each do |v|
          begin
            (failures <<  "[QA weight Fail] Product '#{product.name}' - '#{v.sku}'") if (v.weight < 0.1 && v.option_value('media-version') != 'Digital Download')

            if v.option_value('media-version') == 'Digital Download'
              (failures <<  "[QA Stock Fail A] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.infinite?
            elsif v.option_value('media-version') == 'DVD'
              (failures <<  "[QA Stock Level is not a number] Product '#{product.name}'") if v.total_on_hand.class != Fixnum
              (failures <<  "[QA Backorderable should be disabled] Product '#{product.name}'") if v.stock_items.first.backorderable?

            elsif  v.option_value('media-version') == 'DVD + Digital Download'
              (failures <<  "[QA Stock Fail C] Product '#{product.name}' - '#{v.sku}'") if v.total_on_hand.class != Fixnum
              (failures <<  "[QA Backorderable should be disabled] Product '#{product.name}'") if v.stock_items.first.backorderable?

            elsif v.option_value('media-version') == 'CD'
              (failures <<  "[QA Stock Fail D] Product '#{product.name}' - '#{v.sku}'") if v.total_on_hand.class != Fixnum
              (failures <<  "[QA Backorderable should be disabled] Product '#{product.name}'") if v.stock_items.first.backorderable?

            elsif  v.option_value('media-version') == 'CD + Digital Download'
              (failures <<  "[QA Stock Fail E] Product '#{product.name}' - '#{v.sku}'") if v.total_on_hand.class != Fixnum
              (failures <<  "[QA Backorderable should be disabled] Product '#{product.name}'") if v.stock_items.first.backorderable?

            end
          rescue Exception => e
              failures <<  "[QA Exception Fail] Product '#{product.name}' - '#{v.sku}' - Exception #{e}"
          end
        end
      elsif !product.available_on.blank?
        product.variants.each do |v|
          (failures <<  "[QA Digital Download Only Weight should be 0] Product '#{product.name}' - '#{v.sku}'") if v.weight < 0.1 && v.option_value('media-version') != 'Digital Download'
          (failures <<  "[QA Backorderable should be disabled] Product '#{product.name}' - '#{v.sku}'") if (v.track_inventory and v.stock_items.first.backorderable?)
        end
      end

      (failures <<  "[QA taxons] Product '#{product.name}'") if product.taxons.empty?

    end

    failures.each{|f| puts f}
  end

end