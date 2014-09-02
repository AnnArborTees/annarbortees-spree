Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
      :mini => '48x48>', # thumbs under image
      :small => '400x400>', # images on category view
      :product => '450x450>', # full product image
      :large => '1000x1000>' # light box image
  }
end