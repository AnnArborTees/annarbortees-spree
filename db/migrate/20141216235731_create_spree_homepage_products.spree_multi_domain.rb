# This migration comes from spree_multi_domain (originally 20141216201928)
class CreateSpreeHomepageProducts < ActiveRecord::Migration
  def change
    create_table :spree_homepage_products do |t|
      t.references :product
      t.references :homepage
      t.integer :position
      t.timestamps
    end
    add_index :spree_homepage_products, :product_id
    add_index :spree_homepage_products, :homepage_id
  end
end
