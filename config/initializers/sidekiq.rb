require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
  config.redis = { :namespace => 'softwear-crm', :url => Figaro.env.redis_url }
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.redis = { :namespace => 'softwear-crm', :url => Figaro.env.redis_url }
end