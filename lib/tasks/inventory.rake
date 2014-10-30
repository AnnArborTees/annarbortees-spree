namespace :inventory do

  desc 'Get a list of products that are sold out'
  task sold_out_products: :environment do
    failures = []

    Spree::Variant.where(track_inventory: true).each do |v|
      if v.total_on_hand == 0
        if !(v.product.has_variants? and v.is_master?)
          failures << "[INVENTORY OUTAGE] Product '#{v.product.name}' - Variant '#{v.sku}'"
        end
      end
    end

    failures.each{|f| puts f}
  end
end