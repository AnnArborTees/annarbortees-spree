Spree::Order.class_eval do
  # -- This kind of thing should now be handled by Payflow fraud protection
  # validate :shipping_and_billing_addresses_must_be_same_country

  state_machine :export_state, :initial => :pending do
    event :export_failed do
      transition :pending => :error
    end

    event :digital_only do
      transition :pending => :digital_only
    end

    event :exported do
      transition :pending => :exported
      transition :error => :exported
    end

    event :fraudulent do
      transition any => :fraudulent
    end

    event :fraud_resolved do
      transition :fraudulent => :pending
    end
  end

  self.whitelisted_ransackable_attributes =  %w[completed_at created_at email number state payment_state shipment_state total export_state]

  def generate_order_number(options = {})
    self.number ||= loop do
      # Make a random number.
      random = Time.now.strftime('%y%m%d-%H%M%S-'+("%04d" % rand(8999)))

      # Use the random number if no other order exists with it.
      if !self.class.exists?(number: random)
        break random
      end
    end
  end

  def confirmation_required?
    false
  end

  def fraudulent_pp_refs
    fraudulent_pp_ref.try(:split, '|') || []
  end

  def add_fraudulent_pp_ref(pp_ref)
    return if pp_ref.blank?
    pp_refs = fraudulent_pp_refs

    unless pp_refs.include?(pp_ref)
      pp_refs << pp_ref
      self.fraudulent_pp_ref = pp_refs.join('|')
    end
  end

  # NOTE slightly modified copy/paste from spree/spree
  def process_payments!
    if pending_payments.empty?
      raise Spree::Core::GatewayError.new Spree.t(:no_pending_payments)
    else
      pending_payments.each do |payment|
        break if payment_total >= total

        begin
          payment.process!
        rescue Spree::Payment::FraudProtectionError => e
          add_fraudulent_pp_ref e.pp_ref
          fraudulent! unless fraudulent?
        end

        if payment.completed?
          self.payment_total += payment.amount
        end
      end
    end
  rescue Spree::Core::GatewayError => e
    result = !!Spree::Config[:allow_checkout_on_gateway_error]
    errors.add(:base, e.message) and return result
  end

  protected

  def shipping_and_billing_addresses_must_be_same_country
    return if shipping_address.blank? || billing_address.blank?

    if shipping_address.country_id != billing_address.country_id
      errors.add(:shipping_address, "Shipping and billing addresses must be in the same country")
    end
  end
end
