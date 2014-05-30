# This migration comes from spree_amazon_fps (originally 20140508184812)
class RenameAmazonCheckoutsToAmazonFpsCheckouts < ActiveRecord::Migration
  def change
    rename_table :spree_amazon_checkouts, :spree_amazon_fps_checkouts
  end
end
