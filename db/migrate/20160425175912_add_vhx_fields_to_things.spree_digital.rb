# This migration comes from spree_digital (originally 20160425162305)
class AddVhxFieldsToThings < ActiveRecord::Migration
  def change
    add_column :spree_products, :vhx_api_key, :string
    add_column :spree_variants, :vhx_product_id, :string
    add_column :spree_users, :vhx_customer_id, :string
  end
end
