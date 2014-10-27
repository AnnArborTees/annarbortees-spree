# This migration comes from spree_annarbortees_theme (originally 20141027201407)
class AddThumbnailToAsset < ActiveRecord::Migration
  def change
    add_column :spree_assets, :thumbnail, :boolean
    add_index :spree_assets, :thumbnail
  end
end
