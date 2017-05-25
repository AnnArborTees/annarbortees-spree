# This migration comes from spree_commission_agents (originally 20170525182655)
class AddNewCommissionDashboardUrlToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :new_commission_dashboard_url, :string
  end
end
