set :output, {:error => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.error.log',
              :standard => '/home/ubuntu/RailsApps/wip.annarbortees.com/shared/log/cron.log'}

every 1.minute do
  rake "shipments:ship_digital"
end

