class Api::V1::Users::ApplicationController < ActionController::API
  before_action :authenticate_user!
end
