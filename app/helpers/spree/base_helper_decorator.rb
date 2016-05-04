module Spree
  BaseHelper.class_eval do
    def export_state_class(export_state)
      case export_state.try(:to_sym) || export_state
      when :exported     then 'complete'
      when :fraudulent   then 'failed'
      when :error        then 'failed'
      when :digital_only then 'complete'
      else
        ''
      end
    end
  end
end