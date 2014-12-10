# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
# role :app, %w{ubuntu@54.221.198.113}
# role :web, %w{ubuntu@54.221.198.113}
# role :db,  %w{ubuntu@54.221.198.113}

set :branch, '2-2-stable'

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '54.221.198.113', user: 'ubuntu', roles: %w{web app db rake bundler}#, my_property: :my_value
server 'ec2-54-146-67-112.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app}#, my_property: :my_value

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
