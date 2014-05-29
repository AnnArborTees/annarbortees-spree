Spree::ProductsController.class_eval do
  before_filter :set_styles, only: :show

  private

  def set_styles
      @styles = @product.option_values_for_option_type(Spree::OptionType.find_by(name: 'apparel-style'))
  end

end