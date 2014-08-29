require 'spec_helper'

feature 'ProductLayout' do
  stub_authorization!

  context 'as an admin with valid credentials, I can ', admin: true, pending: false do

    let!(:shipping_category) {create(:shipping_category, name: 'Default')}

    let!(:product_in_test)  {
      create(:product_in_test,
             shipping_category: shipping_category
      )
    }

    scenario 'assign a layout to a product', js: false, wip: false do
      visit admin_product_path(product_in_test)
      within '[data-hook="admin_product_form_right"]' do
        select 'Imprinted Apparel', from: 'Layout'
      end
      click_button 'Update'
      expect(product_in_test.reload.layout).to eq('imprinted_apparel')
    end
  end

end