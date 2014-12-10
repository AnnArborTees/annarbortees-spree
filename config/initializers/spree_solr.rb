Spree::Search::Filters.instance.add do |f|
  f.display_name = 'Price'
  f.search_condition = :any
  f.search_param = 'price'
  f.values { [0..10, 10..20, 20..30] }
end

module Sunspot::Search
  PaginatedCollection.class_eval do
    def maximum(column)
      maximum_record = self.max { |a, b| a.send(column) <=> b.send(column) }
      return 0 if maximum_record.nil?
      maximum_record.send(column)
    end
  end
end