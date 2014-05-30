Spree::Image.class_eval do
  Paperclip.interpolates :product_id_partition do |attachment, style|
    case id = attachment.instance.viewable.product.id
      when Integer
        ("%09d" % id).scan(/\d{3}/).join("/")
      when String
        id.scan(/.{3}/).first(3).join("/")
      else
        nil
    end
  end
end