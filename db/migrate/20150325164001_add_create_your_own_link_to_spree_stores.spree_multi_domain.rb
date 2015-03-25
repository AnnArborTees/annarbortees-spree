# This migration comes from spree_multi_domain (originally 20150313175640)
class AddCreateYourOwnLinkToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :create_your_own_link, :string
  end
end
