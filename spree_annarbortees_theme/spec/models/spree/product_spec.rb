require 'spec_helper'

describe Spree::Product do

  context "A product doesn't have the option types 'apparel-size' and 'apparel-style' assigned with a variant defined" do
    subject { build(:product, layout: 'imprinted_apparel') }
    it { is_expected.to_not be_valid}
  end

  context "A product has the option types 'apparel-size' and 'apparel-style' assigned with a variant defined" do
    subject { create(:base_product) }

    before(:each) do
      option_types = %w(apparel-style apparel-size)
      option_types.each do |option|
        ot = Spree::OptionType.create!(name: option, presentation: option)
        subject.option_types << ot
      end
      variant = Spree::Variant.create!(product_id: subject.id, sku: 'TEST-SKU')
      option_types.each { |option| variant.set_option_value(option, option) }
    end

    it { is_expected.to be_valid }

  end

end