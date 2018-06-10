class ApplicationController < ActionController::Base
  include Banken
  include LineClient
  protect_from_forgery with: :exception
  rescue_from Banken::NotAuthorizedError, with: :account_not_authorized

  private

  def account_not_authorized(exception)
    loyalty_name = exception.loyalty.class.to_s.underscore
    flash[:error] = t "#{loyalty_name}.#{exception.query}", scope: "banken", default: :default
  end
end
