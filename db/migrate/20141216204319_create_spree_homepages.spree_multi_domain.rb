# This migration comes from spree_multi_domain (originally 20141216182105)
class CreateSpreeHomepages < ActiveRecord::Migration
  def change
    create_table :spree_homepages do |t|
      t.string :name
      t.integer :store_id
      t.timestamps
    end
    add_index :spree_homepages, :store_id
  end
end
