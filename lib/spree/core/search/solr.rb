module Spree::Core::Search
  class Solr
    attr_accessor :current_user
    attr_accessor :current_currency

    def initialize(params)
      page = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
      @search_result = Spree::Product.solr_search do
        # execute your search here
        paginate page: page, per_page: Spree::Config[:products_per_page]
      end
    end

    def retrieve_products
      @search_result.results
    end
  end
end