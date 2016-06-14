Spree::OrderMailer.class_eval do
  helper 'spree/base'

  layout 'spree/layouts/email'

  def digital_downloads_ready(order)
    @order = order

    mail(
      to: @order.email,
      from: Spree::Config[:mails_from],
      subject: "Your Digital Download Links are Now Available!"
    )
  end
end