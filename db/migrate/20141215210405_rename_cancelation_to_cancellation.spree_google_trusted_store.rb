# This migration comes from spree_google_trusted_store (originally 20141215205433)
class RenameCancelationToCancellation < ActiveRecord::Migration
  def change
    rename_column :spree_google_trusted_store_settings,
                  :last_cancelation_upload, :last_cancellation_upload
  end
end
