# Rubinius calls Enumerator#sort! within Enumerator#sort_by,
# # and Mail::PartsList calls sort_by within sort!... See the
# problem?

if RUBY_ENGINE == 'rbx'
  Mail::PartsList.class_eval do
    def map!(&block)
      Mail::PartsList.new(collect(&block))
    end

    def sort!(order = nil)
      return super() if order.nil?

      i = 0
      sorted = self.sort_by do |a|
        [get_order_value(a, order), i += 1]
      end
      self.clear
      sorted.each(&self.method(:<<))
    end
  end
end
