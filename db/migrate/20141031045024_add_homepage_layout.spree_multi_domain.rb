# This migration comes from spree_multi_domain (originally 20141031123456)
class AddHomepageLayout < ActiveRecord::Migration
  def change
    add_column :spree_stores, :homepage_layout, :string
  end
end
