module Spree
  module Api
    class TaxCategoriesController < Spree::Api::BaseController

      def index
        @tax_categories = Spree::TaxCategory.all.order(:name)
        respond_with @tax_categories
      end

      def show
        @tax_categories = Spree::TaxCategory.find(params[:id])
        respond_with @tax_categories
      end

    end
  end
end
