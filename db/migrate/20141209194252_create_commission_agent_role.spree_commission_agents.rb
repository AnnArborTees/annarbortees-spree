# This migration comes from spree_commission_agents (originally 20141209194143)
class CreateCommissionAgentRole < ActiveRecord::Migration
  def change
    Spree::Role.where(:name => "commission agent").first_or_create
  end
end
