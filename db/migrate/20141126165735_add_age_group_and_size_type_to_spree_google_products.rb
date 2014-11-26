class AddAgeGroupAndSizeTypeToSpreeGoogleProducts < ActiveRecord::Migration
  def change
    add_column :spree_google_products, :age_group, :string
    add_column :spree_google_products, :size_type, :string
  end
end
