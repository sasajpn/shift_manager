class Api::V1::Owners::ApplicationController < ActionController::API
  before_action :authenticate_owner!
end
