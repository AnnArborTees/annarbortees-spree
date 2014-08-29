Spree::Admin::ProductsController.class_eval do

  alias_method :original_load_data, :load_data

  private

  def load_data
    @layouts = Spree::Product::LAYOUTS
    original_load_data
  end

end