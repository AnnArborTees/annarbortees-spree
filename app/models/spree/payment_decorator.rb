module PaymentOverrides
  FRAUD_SERVICE_REVIEW_CODE = 126

  def handle_response(response, success_state, failure_state)
    if payment_method.kind_of?(Spree::Gateway::PayflowPro) && response.params['result'].to_i == FRAUD_SERVICE_REVIEW_CODE
      record_response(response)
      pp_ref = "#{response.params['pp_ref']} (#{response.params['triggered_message']})"
      raise Spree::Payment::FraudProtectionError.new response.params['message'], pp_ref
    end

    super
  end
end

Spree::Payment.class_eval do
  include PaymentOverrides

  class FraudProtectionError < StandardError
    attr_accessor :pp_ref

    def initialize(message, pp_ref)
      super(message)
      self.pp_ref = pp_ref
    end
  end
end