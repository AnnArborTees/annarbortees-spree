namespace :stage do

  desc 'Prepare API settings in staging environment'
  task setup_api: :environment do

    # create API user
    admin_role = Spree::Role.find_or_create_by(name: 'admin')
    user = Spree::User.find_or_initialize_by(email: 'staging-api-user@softwearcrm.com')
    user.email = 'staging-api-user@softwearcrm.com'
    user.password = 'pw4staging-api-user'
    user.authentication_token = 'authentication-token'
    user.spree_roles << admin_role
    user.save

    # set softwear-crm user
    crm_settings = Spree::CrmSettings.find_or_initialize_by(type: 'Spree::CrmSettings')
    crm_settings[:homepage] = 'http://staging.crm.softwearcrm.com'
    crm_settings[:api_endpoint] = 'http://staging.crm.softwearcrm.com/api'
    crm_settings[:auth_email] = 'staging-api-user@softwearcrm.com'
    crm_settings[:auth_token] = 'authentication-token'
    crm_settings.save

    # set softwear-mockbot user
    mockbot_settings = Spree::MockbotSettings.find_or_initialize_by(type: 'Spree::MockbotSettings')
    mockbot_settings[:homepage] = 'http://staging.mockbot.softwearcrm.com'
    mockbot_settings[:api_endpoint] = 'http://staging.mockbot.softwearcrm.com/api'
    mockbot_settings[:auth_email] = 'staging-api-user@softwearcrm.com'
    mockbot_settings[:auth_token] = 'authentication-token'
    mockbot_settings.save

  end

end
