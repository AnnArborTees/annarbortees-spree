# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  config.allow_ssl_in_production = false
  config.products_per_page = 48
  config.admin_products_per_page = 24



end

if !Rails.env.test?
  Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:product_id_partition/:style/:basename.:extension'
  Spree::Image.attachment_definitions[:attachment][:url] = 'spree/products/:product_id_partition/:style/:basename.:extension'
  Spree::HomepageSlide.attachment_definitions[:image][:path] = '/spree/homepage_slides/:id/:style/:basename.:extension'
  Spree::HomepageSlide.attachment_definitions[:image][:url] = '/spree/homepage_slides/:id/:style/:basename.:extension'
  Spree::Digital.attachment_definitions[:attachment][:path] = '/spree/private/digitals/:id/:basename.:extension'
  Spree::Digital.attachment_definitions[:attachment][:url] = '/spree/private/digitals/:id/:basename.:extension'
end


Spree.user_class = "Spree::User"

config = Rails.application.config
config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::PromoRate

Rails.application.config.spree.stock_splitters = [
    Spree::Stock::Splitter::Backordered
]
