class AddExportedState < ActiveRecord::Migration
  def change
    add_column :spree_orders, :export_state, :string, index: true
    Spree::Order.update_all(export_state: :pending)
  end
end
