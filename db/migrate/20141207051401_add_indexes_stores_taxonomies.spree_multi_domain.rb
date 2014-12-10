# This migration comes from spree_multi_domain (originally 20141207051050)
class AddIndexesStoresTaxonomies < ActiveRecord::Migration
  def change
    add_index :spree_taxonomies_stores, :store_id
    add_index :spree_taxonomies_stores, :taxonomy_id
  end
end
