# This migration comes from spree_amazon_fps (originally 20140425165017)
class CreateSpreeAmazonCheckouts < ActiveRecord::Migration
  def change
    create_table :spree_amazon_checkouts do |t|
      t.string :transaction_id
      t.string :status
      t.timestamps
    end
  end
end
