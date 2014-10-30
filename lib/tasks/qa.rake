namespace :qa do

  desc 'QA Shipping Methods'
  task shipping_methods: :environment do
    Spree::ShippingMethod.all.each do |sm|
      puts "[QA Shipping Method Fail] Shipping Method - '#{sm.name}'" if sm.name.blank? or sm.admin_name.blank? or sm.tracking_url.blank?
    end
  end

  desc 'QA Products'
  task products: :environment do
    failures = []

    Spree::Product.all.each do |product|
      (failures <<  "[QA images Fail] Product '#{product.name}'")  if !product.available_on.blank? && product.images.empty?

      if product.layout == 'imprinted_apparel'
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
              (failures <<  "[QA Stock Fail] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.infinite?
            elsif v.option_value('media-version') == 'DVD'
              (failures <<  "[QA Stock Fail] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.class != 'Fixnum'
            elsif  v.option_value('media-version') == 'DVD + Digital Download'
              (failures <<  "[QA Stock Fail] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.class != 'Fixnum'
            elsif v.option_value('media-version') == 'CD'
              (failures <<  "[QA Stock Fail] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.class != 'Fixnum'
            elsif  v.option_value('media-version') == 'CD + Digital Download'
              (failures <<  "[QA Stock Fail] Product '#{product.name}' - '#{v.sku}'") if !v.total_on_hand.class != 'Fixnum'
            end
          rescue Exception => e
              failures <<  "[QA Exception Fail] Product '#{product.name}' - '#{v.sku}' - Exception #{e}"
          end
        end
      else
        product.variants.each do |v|
          (failures <<  "[QA weight Fail] Product '#{product.name}' - '#{v.sku}'") if v.weight < 0.1 && v.option_value('media-version') != 'Digital Download'
        end
      end

    end

    failures.each{|f| puts f}
  end

end