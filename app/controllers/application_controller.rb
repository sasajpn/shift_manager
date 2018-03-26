class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery with: :exception
end
