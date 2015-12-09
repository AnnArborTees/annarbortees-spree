Spree::Api::OrdersController.class_eval do

  private

  def admin_order_attributes
    [:import, :number, :completed_at, :locked_at, :channel, :export_state]
  end

end