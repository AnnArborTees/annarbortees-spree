object false

node(:count) { @tax_categories.size }
node(:total_count) { @tax_categories.size }
child(@tax_categories => :tax_categories) do
  extends 'spree/api/tax_categories/show'
end
