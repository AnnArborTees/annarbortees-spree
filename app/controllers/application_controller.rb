class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper Spree::GoogleTrustedStoreHelper

  before_filter :assign_response_global_if_admin

  def assign_response_global_if_admin
    return unless is_a?(Spree::Admin::ResourceController)

    Thread.current[:request] = request
  end
end
