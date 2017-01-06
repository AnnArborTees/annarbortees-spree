class AddIndexOnWwwToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :index_on_www, :boolean
  end
end
