# This migration comes from spree_annarbortees_twitter (originally 20141212201911)
class CreateSpreeTwitterHashtags < ActiveRecord::Migration
  def change
    create_table :spree_twitter_hashtags do |t|
      t.string :value
      t.timestamps
    end
  end
end
