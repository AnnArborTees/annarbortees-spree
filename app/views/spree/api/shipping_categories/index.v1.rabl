object false

node(:count) { @shipping_categories.size }
node(:total_count) { @shipping_categories.size }
child(@shipping_categories => :shipping_categories) do
  extends 'spree/api/shipping_categories/show'
end
