module Spree
  module Api
    class ShippingCategoriesController < Spree::Api::BaseController

      def index
        @shipping_categories = Spree::ShippingCategory.all.order(:name)
        respond_with @shipping_categories
      end

      def show
        @shipping_categories = Spree::ShippingCategory.find(params[:id])
        respond_with @shipping_categories
      end

    end
  end
end
