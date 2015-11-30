ec2_role :app, user: 'ubuntu'
ec2_role :db, user: 'ubuntu'
ec2_role :web, user: 'ubuntu'
ec2_role :cron, user: 'ubuntu'


set :branch, '2-2-stable'
set :linked_files, fetch(:linked_files) + %w{config/sidekiq.yml}
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
