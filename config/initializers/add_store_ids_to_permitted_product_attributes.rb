unless Spree::Api::ApiHelpers.product_attributes.include?(:store_ids)
  Spree::Api::ApiHelpers.product_attributes << :store_ids
end
