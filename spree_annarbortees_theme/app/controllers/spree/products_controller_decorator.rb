Spree::ProductsController.class_eval do
  before_filter :load_option_data, only: :show

  private

  def load_option_data
      if @product.layout == 'imprinted_apparel'
        @styles = @product.option_values_for_option_type(Spree::OptionType.find_by(name: 'apparel-style'))
      end
  end

end