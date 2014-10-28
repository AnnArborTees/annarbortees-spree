# This migration comes from spree_annarbortees_theme (originally 20141028150216)
class AddPreviewToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :digital_preview, :text
  end
end
