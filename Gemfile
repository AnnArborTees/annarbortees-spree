source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.8'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'


# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'figaro'


gem 'spree', github: 'spree/spree', branch: '2-2-stable'
gem 'spree_gateway', :git => 'https://github.com/spree/spree_gateway.git', :branch => '2-2-stable'
gem 'spree_auth_devise', :git => 'https://github.com/spree/spree_auth_devise.git', :branch => '2-2-stable'

group :development do
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end

gem 'asset_sync'
gem 'sprockets', '=2.11.0'
gem 'spree_multi_domain', github: 'annarbortees/spree-multi-domain', :branch => '2-2-stable'
gem 'spree_amazon_fps', github: 'annarbortees/spree_amazon_fps', branch: '2-2-stable'
gem 'spree_annarbortees_theme', github: 'annarbortees/spree_annarbortees_theme', branch: '2-2-stable'
gem 'spree_active_shipping', github: 'spree/spree_active_shipping', branch: '2-2-stable'
gem 'spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express', branch: '2-2-stable'
gem 'spree_sizing_guides', github: 'annarbortees/spree_sizing_guides', branch: '2-2-stable'
gem 'spree_digital', github: 'annarbortees/spree_digital', branch: '2-2-stable'
gem 'spree_mockbot_integration', git: "https://#{ENV['GITHUB_OAUTH_KEY']}:x-oauth-basic@github.com/annarbortees/spree_mockbot_integration.git", branch: '2-2-stable'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'