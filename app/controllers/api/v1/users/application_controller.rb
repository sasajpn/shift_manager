class Api::V1::Users::ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end

  def set_current_member
    @current_member = current_user.approval_members.find_by(team_id: @team.id)
  end
end
