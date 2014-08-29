Spree::Product.class_eval do
  validate :product_configured_properly_for_layout

  LAYOUTS = {
      'Default' => 'default',
      'Imprinted Apparel' => 'imprinted_apparel'
  }

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

  private

  def product_configured_properly_for_layout
    if self.layout == 'imprinted_apparel'
     style = Spree::OptionType.find_by(name: 'apparel-style')
     size = Spree::OptionType.find_by(name: 'apparel-size')
      # errors.add(:layout, 'Must define apparel-style in order to use this layout') unless self.option_types.include? style
      # errors.add(:layout, 'Must define apparel-size in order to use this layout') unless self.option_types.include? size
      errors.add(:layout, "Must define Option Value 'apparel-style' and at least
        one variant in order to use this layout") if self.option_values_for_option_type(style).empty?
     errors.add(:layout, "Must define Option Value 'apparel-size' and at least
        one variant in order to use this layout") if self.option_values_for_option_type(size).empty?
    end
  end

end