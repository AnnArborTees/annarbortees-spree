require 'spec_helper'

feature 'ProductLayout' do
  context 'as a site visitor I visit a product with the default layout ', admin: true, pending: false do

    let(:store) { create(:store) }
    let(:product) { create(:base_product, layout: 'default', stores: [store]) }


    scenario 'it renders the default layout ', js: false, wip: false do
      visit spree.product_path(product)
      expect(page).to have_css('#variantTabs')
    end
  end

end