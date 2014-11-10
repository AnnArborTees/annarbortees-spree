# This migration comes from spree_multi_domain (originally 20141110201308)
class StoresHabtmTaxonomies < ActiveRecord::Migration
  def change
    create_table :spree_taxonomies_stores, id: false do |t|
      t.integer :taxonomy_id
      t.integer :store_id
    end

    Spree::Taxonomy.all.each do |taxonomy|
      taxonomy.stores << Spree::Store.find(taxonomy.store_id)
    end

    remove_column :spree_taxonomies, :store_id, :integer

  end
end
