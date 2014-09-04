# This migration comes from spree_mockbot_integration (originally 20140721115412)
class CreateMockbotSettings < ActiveRecord::Migration
  def change
    create_table :spree_mockbot_settings do |t|
      t.integer :singleton_guard

      t.string :auth_email
      t.string :auth_token

      t.string :mockbot_home
      t.string :api_endpoint
    end

    add_index :spree_mockbot_settings, :singleton_guard, unique: true
  end
end