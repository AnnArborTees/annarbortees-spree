# This migration comes from spree_multi_domain (originally 20140411204502)
class AddUrlIndexToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :url_index, :integer
  end
end
