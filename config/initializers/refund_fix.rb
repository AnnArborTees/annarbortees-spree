# The Authorize.net payment gateway is totally broken, and this should fix it.
# (Along with other changes inside admin/orders_controller_decorator and order_decorator.

Spree::Payment::Processing.class_eval do
  alias_method :original_gateway_options, :gateway_options

  def gateway_options
    order.payments.find_each do |payment|
      next unless payment.payment_method.type == 'Spree::Gateway::AuthorizeNet'

      return original_gateway_options.merge(
        card_number: payment.source.last_digits
      )
    end

    original_gateway_options
  end
end

