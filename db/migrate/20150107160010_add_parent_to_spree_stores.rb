class AddParentToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :parent_id, :integer
    remove_column :spree_stores, :url_index
  end
end
