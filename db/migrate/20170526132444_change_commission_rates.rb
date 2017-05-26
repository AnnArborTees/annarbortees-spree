class ChangeCommissionRates < ActiveRecord::Migration
  def change
    change_column :spree_commission_agents, :rate, precision: 8, scale: 2
  end
end
