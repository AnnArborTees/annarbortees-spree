# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'annarbortees-spree'
set :repo_url, 'git@github.com:annarbortees/annarbortees-spree.git'
set :rvm_ruby_version, 'rbx-2.5.2'
set :deploy_to, '/home/ubuntu/RailsApps/wip.annarbortees.com'
set :assets_prefix, 'spree/assets'


set :linked_files, %w{config/remote_database.yml config/database.yml config/application.yml config/sunspot.yml config/asset_sync.yml config/business_time.yml}
set :linked_dirs, %w{solr}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { 'GITHUB_OAUTH_KEY' => ENV['GITHUB_OAUTH_KEY'] }

# Default value for keep_releases is 5
# set :keep_releases, 5

Rake::Task["deploy:compile_assets"].clear

namespace :deploy do

  # after :updated, "assets:precompile"

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

  desc 'Compile assets'
  task :compile_assets => [:set_rails_env] do
    # invoke 'deploy:assets:precompile'
    invoke 'deploy:assets:precompile_local'
    invoke 'deploy:assets:backup_manifest'
  end


  namespace :assets do

    desc "Precompile assets locally and then rsync to web servers"
    task :precompile_local do
      # compile assets locally
      run_locally do
        execute "RAILS_ENV=#{fetch(:stage)} bundle exec rake assets:precompile"
      end

      # rsync to each server
      local_dir = "./public/assets/"
      on roles( fetch(:assets_roles, [:web]) ) do
        # this needs to be done outside run_locally in order for host to exist
        remote_dir = "#{host.user}@#{host.hostname}:#{release_path}/public/assets/"

        run_locally { execute "rsync -av --delete #{local_dir} #{remote_dir}" }

        execute :rake, 'assets:sync'
      end

      # clean up
      run_locally { execute "rm -rf #{local_dir}" }
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
