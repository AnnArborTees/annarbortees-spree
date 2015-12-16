# This migration comes from spree_annarbortees_theme (originally 20151216214421)
class AddDontSplitBackorderedShipments < ActiveRecord::Migration
  def change
    add_column :spree_orders, :dont_split_packages_on_backorder, :boolean, default: false, index: true
  end
end
