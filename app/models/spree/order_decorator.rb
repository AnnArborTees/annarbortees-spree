Spree::Order.class_eval do

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

end
