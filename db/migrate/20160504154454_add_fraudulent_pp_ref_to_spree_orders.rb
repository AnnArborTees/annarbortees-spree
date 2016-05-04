class AddFraudulentPpRefToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :fraudulent_pp_ref, :string
  end
end
