set :output, {:error => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.error.log',
              :standard => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.log'}

every 30.minutes do
  rake "twitter:populate_tweets"
end
