# This migration comes from spree_amazon_fps (originally 20140502142140)
class AddPaymentMethodToSpreeAmazonCheckouts < ActiveRecord::Migration
  def change
    add_column :spree_amazon_checkouts, :payment_method_id, :integer
  end
end
