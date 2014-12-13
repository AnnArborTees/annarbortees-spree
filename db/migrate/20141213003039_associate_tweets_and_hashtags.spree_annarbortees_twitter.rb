# This migration comes from spree_annarbortees_twitter (originally 20141212201600)
class AssociateTweetsAndHashtags < ActiveRecord::Migration
  def change
    create_join_table :spree_twitter_hashtags, :spree_twitter_tweets do |t|
      t.index [:spree_twitter_tweet_id, :spree_twitter_hashtag_id], name: 'by_tweets_hashtags'
      t.index [:spree_twitter_hashtag_id, :spree_twitter_tweet_id], name: 'by_hashtags_tweets'
    end
  end
end
