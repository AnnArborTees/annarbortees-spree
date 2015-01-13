# This migration comes from spree_multi_domain (originally 20150107160010)
class AddParentToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :parent_id, :integer
    remove_column :spree_stores, :url_index
  end
end
