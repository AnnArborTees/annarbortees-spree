# This migration comes from spree_multi_domain (originally 20150126203335)
class AddStoreIdToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :store_id, :integer
  end
end
