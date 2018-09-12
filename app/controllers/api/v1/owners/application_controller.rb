class Api::V1::Owners::ApplicationController < ActionController::API
  before_action :authenticate_owner!

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end
end
