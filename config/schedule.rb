if ENV['RAILS_ENV'] == 'production'
  set :output, {:error => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.error.log',
                :standard => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.log'}

  every 1.minute do
    rake "shipments:ship_digital"
  end

  every 2.minutes do
    rake "twitter:populate_tweets"
  end
end
