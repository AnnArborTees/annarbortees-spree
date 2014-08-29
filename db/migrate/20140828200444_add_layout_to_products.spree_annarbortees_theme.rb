# This migration comes from spree_annarbortees_theme (originally 20140828190533)
class AddLayoutToProducts < ActiveRecord::Migration
  def change

    change_table :spree_products do |t|
      t.string :layout, default: default
    end

    add_index :spree_products, :layout

  end
end
