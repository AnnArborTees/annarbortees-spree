class AddSeoTitleAndSlugToStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :seo_title, :string
    add_column :spree_stores, :slug, :string
    add_index :spree_stores, :slug
  end
end
