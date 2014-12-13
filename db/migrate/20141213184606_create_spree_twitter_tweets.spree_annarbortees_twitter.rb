# This migration comes from spree_annarbortees_twitter (originally 20141212201939)
class CreateSpreeTwitterTweets < ActiveRecord::Migration
  def change
    create_table :spree_twitter_tweets do |t|
      t.string :in_reply_to_screen_name
      t.integer :in_reply_to_status_id
      t.integer :in_reply_to_user_id
      t.string :lang
      t.integer :retweet_count
      t.text :source
      t.text :attrs
      t.text :url
      t.timestamps
    end
    
    add_column :spree_twitter_tweets, :tweet_id, 'BIGINT UNSIGNED'
    add_index :spree_twitter_tweets, :tweet_id
  end
end
