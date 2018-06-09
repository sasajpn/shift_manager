class ApplicationController < ActionController::Base
  include LineClient
  protect_from_forgery with: :exception
end
