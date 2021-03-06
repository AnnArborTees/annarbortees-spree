Spree::Admin::OrdersController.class_eval do

  def cancel
    begin
      @order.cancel!
      flash[:success] = Spree.t(:order_canceled)
      cancelled = true

    rescue Spree::Core::GatewayError => error
      flash[:error] = "Gateway error: #{error.message}"
      cancelled = false

    rescue NoMethodError => error
      if error.message.include? 'PayPal'
        flash[:error] = "Order is cancelled, but PayPal payments must be cancelled manually."
        cancelled = true
      else
        flash[:error] = "The payment gateway in this order doesn't seem to support cancelation."
        cancelled = false
      end
    end

    redirect_to :back, just_cancelled_order: cancelled
  end

  def resolve_fraud
    @order.fraud_resolved
    @order.payment_total = @order.payments.map(&:amount)
    @order.payments.each { |p| p.state = 'completed' }
    @order.finalize!

    if @order.save
      @order.payments.each(&:save)
      flash[:success] = "Payments marked as complete and export pending."
    else
      flash[:error] = @order.errors.full_messages.join(", ")
    end

    redirect_to :back
  end

end
