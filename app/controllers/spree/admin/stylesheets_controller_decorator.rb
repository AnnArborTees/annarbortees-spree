Spree::Admin::StylesheetsController.class_eval do
  before_filter :expire_cache, only: [:update, :destroy]

  private

  def expire_cache
    expire_page controller: '/spree/stylesheets', action: 'show', id: params[:id], format: 'css'
  end


end