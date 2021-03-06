class Api::V1::Users::ApplicationController < ActionController::API
  include ActionController::Flash
  include Banken
  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!

  private

  def set_team
    @team = Team.find_by(id: params[:id] || params[:team_id])
  end

  def set_member
    @member = Member.find_by(id: params[:id] || params[:member_id])
  end

  def set_current_member
    @current_member = current_user.approval_members.find_by(team_id: @team.id)
  end

  def user_not_authorized
    render json: { message: 'アクセス権限がありません' }, status: 404
  end
end
