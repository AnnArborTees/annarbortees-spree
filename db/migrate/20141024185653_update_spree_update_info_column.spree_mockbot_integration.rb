# This migration comes from spree_mockbot_integration (originally 20141024185113)
class UpdateSpreeUpdateInfoColumn < ActiveRecord::Migration
  def change
    change_column :spree_updates, :info, :text
  end
end
