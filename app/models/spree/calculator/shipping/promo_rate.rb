require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class PromoRate < ShippingCalculator
      preference :max_weight, :decimal, default: 13.0
      preference :amount, :decimal, default: 0

      def self.description
        Spree.t(:promo_rate)
      end

      # as object we always get line items, as calculable we have Coupon, ShippingMethod
      def compute_package(package)
        return self.preferred_amount
      end

      def available?(package)
        package.weight <= self.preferred_max_weight
      end
    end
  end
end
