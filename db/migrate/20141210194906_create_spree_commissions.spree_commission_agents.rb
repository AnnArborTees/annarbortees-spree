# This migration comes from spree_commission_agents (originally 20141209203741)
class CreateSpreeCommissions < ActiveRecord::Migration
  def change
    create_table :spree_commissions do |t|
      t.decimal :amount, scale: 2, precision: 10 
      t.integer :commission_agent_id
      t.integer :line_item_id
      t.timestamps
    end
  end
end
