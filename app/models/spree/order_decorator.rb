Spree::Order.class_eval do
  validate :shipping_and_billing_addresses_must_be_same_country

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

  protected

  def shipping_and_billing_addresses_must_be_same_country
    return if shipping_address.blank? || billing_address.blank?

    if shipping_address.country_id != billing_address.country_id
      errors.add(:shipping_address, "Shipping and billing addresses must be in the same country")
    end
  end
end
