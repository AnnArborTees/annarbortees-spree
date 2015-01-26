Spree::Order.class_eval do

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
