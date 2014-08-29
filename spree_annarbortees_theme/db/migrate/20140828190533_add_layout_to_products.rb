class AddLayoutToProducts < ActiveRecord::Migration
  def change

    change_table :spree_products do |t|
      t.string :layout, default: 'default'
    end

    add_index :spree_products, :layout

  end
end
