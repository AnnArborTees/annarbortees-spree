Spree::Product.class_eval do

  def option_values_for_option_type(option_type)
    option_type_id = (option_type.nil? ? nil : option_type.id)
    Spree::OptionValue.
        joins(:variants).
        where(spree_variants:{product_id: self.id}, option_type_id: option_type_id).
        group(:option_value_id).
        order(:position)
  end

  def variants_with_option_value(option_value)
    variants.joins(:option_values).where(spree_option_values: {id: option_value.id}).order(:position)
  end
end