# This migration comes from spree_multi_domain (originally 20130311214205)
class AddDefaultCurrencyToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :default_currency, :string
  end
end
