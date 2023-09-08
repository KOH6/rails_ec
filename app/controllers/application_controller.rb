# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cart_id

  def set_cart_id
    session[:cart_id] ||= Cart.create.id
    logger.debug("session")
    logger.debug(session[:cart_id])
  end
end
