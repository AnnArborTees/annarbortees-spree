Spree::Admin::OrdersController.class_eval do

  def cancel
    begin
      @order.cancel!
      flash[:success] = Spree.t(:order_canceled)

    rescue Spree::Core::GatewayError => error
      flash[:error] = "Gateway error: #{error.message}"
    end

    redirect_to :back
  end

end
