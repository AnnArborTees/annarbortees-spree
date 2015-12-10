# This migration comes from spree_annarbortees_theme (originally 20151205193052)
class AddBackorderDetailsToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :backorder_details, :text
  end
end
