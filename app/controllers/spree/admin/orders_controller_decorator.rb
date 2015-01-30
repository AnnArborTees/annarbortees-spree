Spree::Admin::OrdersController.class_eval do

  def cancel
    begin
      @order.cancel!
      flash[:success] = Spree.t(:order_canceled)
      cancelled = true

    rescue Spree::Core::GatewayError => error
      flash[:error] = "Gateway error: #{error.message}"
      cancelled = false
    end

    redirect_to :back, just_cancelled_order: cancelled
  end

end
