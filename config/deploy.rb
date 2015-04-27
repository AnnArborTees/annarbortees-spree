# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'annarbortees-spree'
set :repo_url, 'git@github.com:annarbortees/annarbortees-spree.git'
set :rvm_ruby_version, 'rbx-2.5.2'
set :deploy_to, '/home/ubuntu/RailsApps/wip.annarbortees.com'
set :assets_prefix, 'spree/assets'


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/remote_database.yml config/database.yml config/application.yml config/sunspot.yml config/asset_sync.yml config/business_time.yml config/sidekiq.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{solr}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { 'GITHUB_OAUTH_KEY' => ENV['GITHUB_OAUTH_KEY'] }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do\
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      #within release_path do
      #   execute :rake, 'cache:clear'
      #end
    end
  end

end

namespace :data do

  desc 'Dump data in envrionment into seed files'
  task :dump do
    on roles(:db) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :rake, 'db:data:dump'
        end
      end
    end
  end

  desc 'Copy remote data to local server'
  task :download do
    run_locally do
      execute "scp ubuntu@#{roles(:db).first}:#{release_path}/db/data.yml ./db/data.yml"
      execute :rake, 'db:data:load'
    end
  end

  desc 'Copy remote data to local server'
  task :dump_and_download do
    on roles(:db) do
      within release_path do
        with rails_env: (fetch(:rails_env) || fetch(:stage)) do
          execute :rake, 'db:data:dump'
        end
      end
    end

    run_locally do
      execute "scp ubuntu@#{roles(:db).first}:#{release_path}/db/data.yml ./db/data.yml"
      execute :rake, 'db:data:load'
    end
  end
end
