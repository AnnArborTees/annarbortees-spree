class AddProductTypeToSpreeGoogleProducts < ActiveRecord::Migration
  def change
    add_column :spree_google_products, :product_type, :string
  end
end
