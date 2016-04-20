require 'spec_helper'

feature 'Checkout' do
  let!(:shipping_method) { create(:shipping_method) }
  let!(:stock_location) { create(:stock_location) }
  let!(:mug) { create(:product, name: "RoR Mug") }
  let!(:payment_method) { create(:check_payment_method) }
  let!(:zone) { create(:zone) }
  let!(:store) { create(:store) }

  let(:country) { create(:country, name: 'United States of America', iso_name: 'UNITED STATES') }
  let(:state) { create(:state, name: 'Alabama', abbr: 'AL', country: country) }

  background(:each) do
    @default_store.homepage.products << mug
    @default_store.products << mug
    shipping_method.calculator.update!(preferred_amount: 10)
    expect(shipping_method.shipping_categories).to_not be_empty
    mug.shipping_category = shipping_method.shipping_categories.first
    mug.save! and mug.reload
  end

  scenario 'A customer can complete checkout in a single page', pending: "can't get shipping to calculate properly", js: true do
    add_mug_to_cart
    first('#checkout-link').click

    fill_in 'order_email', with: 'test@example.com'
    click_button 'Continue'

    fill_in_address
    sleep 3
    sleep 3

    click_button 'place-order-button'

    sleep 2.5

    expect(Spree::Order.last).to be_complete
  end

  def fill_in_address
    address = "order_bill_address_attributes"
    fill_in "#{address}_firstname", with: "Ryan"
    fill_in "#{address}_lastname", with: "Bigg"
    fill_in "#{address}_address1", with: "143 Swan Street"
    fill_in "#{address}_city", with: "Richmond"
    select country.name, from: "#{address}_country_id"
    select state.name, from: "#{address}_state_id"
    fill_in "#{address}_zipcode", with: "12345"
    fill_in "#{address}_phone", with: "(555) 555-5555"
  end

  def add_mug_to_cart
    visit spree.store_path(@default_store)
    visit '/products/ror-mug'
    click_button "BUY"
  end
end
