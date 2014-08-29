require 'spec_helper'

feature 'Admin::ProductLayout' do
  stub_authorization!

  context 'as an admin with valid credentials, I can ', admin: true, pending: false  do

    let!(:product) { create(:base_product) }

    before(:each) do
      option_types = %w(apparel-style apparel-size)
      option_types.each do |option|
        ot = Spree::OptionType.create!(name: option, presentation: option)
        product.option_types << ot
      end

      variant = Spree::Variant.create!(product_id: product.id, sku: 'TEST-SKU')
      option_types.each { |option| variant.set_option_value(option, option) }
    end

    scenario 'assign a layout to a product', js: false, wip: false do
      visit spree.admin_product_path(product)
      within '[data-hook="admin_product_form_right"]' do
        select 'Imprinted Apparel', from: 'Layout'
      end
      click_button 'Update'
      expect(product.reload.layout).to eq('imprinted_apparel')
    end
  end

end