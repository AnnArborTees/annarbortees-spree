# This migration comes from spree_mockbot_integration (originally 20140725012300)
class DropMockbotSettingsAndCreateApiSettings < ActiveRecord::Migration
  def change
    drop_table :spree_mockbot_settings

    create_table :spree_api_settings do |t|
      t.string :type

      t.string :homepage
      t.string :api_endpoint

      t.string :auth_email
      t.string :auth_token
    end

    add_index :spree_api_settings, :type, unique: true
  end
end