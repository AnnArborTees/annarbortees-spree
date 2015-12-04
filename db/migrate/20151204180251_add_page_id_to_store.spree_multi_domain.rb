# This migration comes from spree_multi_domain (originally 20151204174633)
class AddPageIdToStore < ActiveRecord::Migration
  def change
    add_column :spree_stores, :page_id, :integer, index: true
  end
end
