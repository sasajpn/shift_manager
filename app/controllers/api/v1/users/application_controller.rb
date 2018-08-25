class Api::V1::Users::ApplicationController < ActionController::API
  include Banken
  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end

  def set_member
    @member = Member.find_by(id: params[:member_id])
  end

  def set_current_member
    @current_member = current_user.approval_members.find_by(team_id: @team.id)
  end

  def user_not_authorized
    render json: { message: 'Access denied' }, status: 404
  end
end
