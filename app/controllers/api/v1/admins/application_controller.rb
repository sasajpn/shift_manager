class Api::V1::Admins::ApplicationController < ActionController::API
  before_action :authenticate_admin!
end
