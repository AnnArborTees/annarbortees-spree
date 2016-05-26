Spree::Api::ProductsController.class_eval do
  private

  def product_params
    product_params = params.require(:product).permit(permitted_product_attributes)

    taxon_ids = params[:product].try(:[], :taxon_ids)
    if taxon_ids.is_a?(Array)
      product_params[:taxon_ids] = taxon_ids
    elsif taxon_ids.is_a?(String)
      product_params[:taxon_ids] = taxon_ids.split(',')
    end
    product_params[:taxon_ids].try :uniq!

    store_ids = params[:product].try(:[], :store_ids)
    if store_ids.is_a?(Array)
      product_params[:store_ids] = store_ids
    elsif store_ids.is_a?(String)
      product_params[:store_ids] = store_ids.split(',')
    end
    product_params[:store_ids].try :uniq!

    product_params
  end
end