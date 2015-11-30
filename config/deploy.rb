# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'annarbortees-spree'
set :repo_url, 'git@github.com:annarbortees/annarbortees-spree.git'
set :rvm_ruby_version, 'rbx-2.5.2,ruby-2.1.2'
set :rvm_task_ruby_version, 'ruby-2.1.2'
set :deploy_to, '/home/ubuntu/RailsApps/wip.annarbortees.com'
set :assets_prefix, 'spree/assets'

set :linked_files, %w{config/remote_database.yml config/database.yml config/application.yml config/sunspot.yml config/asset_sync.yml config/business_time.yml}
set :linked_dirs, %w{solr}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  'GITHUB_OAUTH_KEY' => ENV['GITHUB_OAUTH_KEY'],
  'GITHUB_USERNAME' => ENV['GITHUB_USERNAME']
}

# Default value for keep_releases is 5
# set :keep_releases, 5

Rake::Task["deploy:compile_assets"].clear

namespace :test do
  task :say_hello do
    on roles(:app) do
      with_rvm 'rbx-2.5.2,ruby-2.2.1' do
        execute :ruby, '-e', %~"puts 'running.........';puts RUBY_ENGINE"~
      end
    end
  end
end

namespace :deploy do

  before :starting, :install_ruby do
    on roles(:app) do
      execute :rvm, 'install', 'ruby-2.1.2'
    end
  end

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

  after :publishing, :restart_sidekiq_manager do
    on roles(:app) do
      unless test('[[ $(sudo status sidekiq-manager) == *Unknown* ]]')
        execute 'sudo restart sidekiq-manager'
      end
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
      assets_dir = "public/#{fetch(:assets_prefix) || 'assets'}"
      local_dir = "./#{assets_dir}/"
      on roles( fetch(:assets_roles, [:web]) ) do
        # this needs to be done outside run_locally in order for host to exist
        remote_dir = "#{host.user}@#{host.hostname}:#{release_path}/#{assets_dir}"

        execute "mkdir -p #{release_path}/#{assets_dir}"
        run_locally { execute "rsync -av --delete #{local_dir} #{remote_dir}" }

        with rails_env: fetch(:rails_env) || fetch(:stage) do
          within(release_path) do
            with_rvm(fetch(:task_ruby_version)) { execute :rake, 'assets:sync' }
          end
        end
      end

      # clean up
      run_locally { execute "rm -rf #{local_dir}" }
    end

  end
end

=begin
namespace :bundler do
  task :pre_install do
    on fetch(:bundle_servers) do
      within release_path do
        # Run once to generate gemfile.lock
        with fetch(:bundle_env_variables, {}) do
          options = ["install"]
          options << "--binstubs #{fetch(:bundle_binstubs)}" if fetch(:bundle_binstubs)
          options << "--gemfile #{fetch(:bundle_gemfile)}" if fetch(:bundle_gemfile)
          options << "--path #{fetch(:bundle_path)}" if fetch(:bundle_path)
          options << "--without #{fetch(:bundle_without)}" if fetch(:bundle_without)
          options << "--jobs #{fetch(:bundle_jobs)}" if fetch(:bundle_jobs)
          options << '--quiet'

          execute :bundle, options
        end
      end
    end
  end

  before :install, :pre_install
end
=end

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
