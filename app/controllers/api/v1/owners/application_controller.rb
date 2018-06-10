class Api::V1::Owners::ApplicationController < ActionController::API
  include Banken
  rescue_from Banken::NotAuthorizedError, with: :owner_not_authorized
  before_action :authenticate_owner!

  def current_user
    current_owner
  end

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end

  def owner_not_authorized
    render json: { message: 'Access denied' }, status: 404
  end
end
