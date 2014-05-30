# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  config.allow_ssl_in_production = false
end

if !Rails.env.test?
  Spree::Image.attachment_definitions[:attachment][:storage] = :s3
  Spree::Image.attachment_definitions[:attachment][:bucket] = Figaro.env['aws_s3_bucket']
  Spree::Image.attachment_definitions[:attachment][:s3_credentials] = {
    access_key_id: Figaro.env['aws_access_key_id'],
    secret_access_key: Figaro.env['aws_secret_access_key']
  }
  Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:product_id_partition/:style/:basename.:extension'
  Spree::Image.attachment_definitions[:attachment][:url] = 'spree/products/:product_id_partition/:style/:basename.:extension'
end

=begin
TODO: Get UPS and USPS shipping keys
Spree::ActiveShipping::Config[:origin_country] = 'United States of America'
Spree::ActiveShipping::Config[:origin_city] = 'Ann Arbor'
Spree::ActiveShipping::Config[:origin_state] = 'MI'
Spree::ActiveShipping::Config[:origin_zip] = '48104'
#Spree::ActiveShipping::Config[:ups_login] =
#Spree::ActiveShipping::Config[:ups_password] =
#Spree::ActiveShipping::Config[:ups_key]
Spree::ActiveShipping::Config[:usps_login] =
=end

Spree.user_class = "Spree::User"
