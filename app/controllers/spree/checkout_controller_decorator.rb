Spree::CheckoutController.class_eval do
  skip_before_action :load_order_with_lock, only: [:complete]
  skip_before_filter :set_state_if_present, only: [:complete]

  skip_before_filter :ensure_order_not_completed, only: [:complete]
  skip_before_filter :ensure_checkout_allowed, only: [:complete]
  skip_before_filter :ensure_sufficient_stock_lines, only: [:complete]
  skip_before_filter :ensure_valid_state, only: [:complete]

  skip_before_filter :associate_user, only: [:complete]
  skip_before_filter :check_authorization, only: [:complete]
  skip_before_filter :apply_coupon_code, only: [:complete]

  skip_before_filter :setup_for_current_state, only: [:complete]


  def complete
    @order = Spree::Order.find(session[:completed_order_id])
    render 'spree/orders/show'
  end

  def completion_route
    session[:completed_order_id] = @order.id
    '/checkedout?checkout_complete=true'
  end
end
