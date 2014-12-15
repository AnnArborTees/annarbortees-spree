namespace :twitter do

  desc 'initialize all hashtags to master sku'
  task populate_hashtags: :environment do
    Spree::Product.all.each do |p|
      p.update_attribute(:hashtag, p.master.sku)
    end
  end

  desc 'find tweets that mention @AnnArborTees'
  task populate_tweets: :environment do
    twitter_config = Spree::TwitterConfiguration.new
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_config.consumer_key
      config.consumer_secret     = twitter_config.consumer_secret
      config.access_token        = twitter_config.access_token
      config.access_token_secret = twitter_config.access_token_secret
    end
   tweets = client.search("annarbortees", result_type: "all")

   tweets.each do |t|
     tweet = Spree::Twitter::Tweet.find_or_initialize_by(tweet_id: t.id)

      if tweet.new_record?
        tweet.lang = t.lang
        tweet.source = t.source
        tweet.url = t.url
        tweet.created_at = t.created_at
     end
     tweet.attrs = t.attrs
     tweet.retweet_count = t.retweet_count
     tweet.save!

   end
    puts "#{tweets.count} tweets"
  end


end