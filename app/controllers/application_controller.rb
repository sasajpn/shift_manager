class ApplicationController < ActionController::Base
  include Banken
  include LineClient
  protect_from_forgery with: :exception
end
