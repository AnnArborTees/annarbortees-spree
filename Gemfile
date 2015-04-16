source 'https://rubygems.org'

gem 'rails', '4.0.12'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

gem 'sinatra'
gem 'sidekiq'
gem 'sidekiq-status'
gem 'sidekiq-failures'


group :doc do
  gem 'sdoc', require: false
end

gem 'figaro'

spree_branch = '2-2-stable'

gem 'spree', github: 'spree/spree', branch: spree_branch
gem 'spree_gateway', github: 'spree/spree_gateway', branch: spree_branch
gem 'spree_auth_devise', github: 'annarbortees/spree_auth_devise', branch: spree_branch

group :development do
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'sunspot_solr'
  gem 'rubinius-debugger', platforms: :rbx
  gem 'byebug', platforms: :mri
end

gem 'asset_sync'
gem 'sprockets', '=2.11.0'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
gem 'whenever'

gem 'spree_multi_domain', github: 'annarbortees/spree-multi-domain', branch: spree_branch
gem 'spree_solr', github: 'annarbortees/spree_solr', branch: spree_branch
gem 'sunspot_rails'
gem 'progress_bar'

gem 'spree_amazon_fps', github: 'annarbortees/spree_amazon_fps', branch: spree_branch
gem 'spree_google_trusted_store', github: 'annarbortees/spree_google_trusted_store', branch: spree_branch
gem 'spree_wishlist', github: 'spree-contrib/spree_wishlist', branch: spree_branch
gem 'spree_annarbortees_theme', github: 'annarbortees/spree_annarbortees_theme', branch: spree_branch
gem 'spree_active_shipping', github: 'spree/spree_active_shipping', branch: spree_branch
gem 'spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express', branch: spree_branch
gem 'spree_sizing_guides', github: 'annarbortees/spree_sizing_guides', branch: spree_branch
gem 'spree_digital', github: 'annarbortees/spree_digital', branch: spree_branch
gem 'spree_mockbot_integration', git: "https://#{ENV['GITHUB_OAUTH_KEY']}:x-oauth-basic@github.com/annarbortees/spree_mockbot_integration.git", branch: spree_branch
gem 'spree_commission_agents', github: 'annarbortees/spree_commission_agents', branch: spree_branch
gem 'spree_annarbortees_twitter', github: 'annarbortees/spree_annarbortees_twitter', branch: spree_branch
gem 'twitter'
gem 'dumpsync', github: 'Resonious/dumpsync', branch: 'master'
gem 'actionpack-page_caching'
gem 'posix-spawn'
