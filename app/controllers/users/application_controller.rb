class Users::ApplicationController < ApplicationController
  layout 'users/application'
  before_action :authenticate_user!

  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end

  def set_current_member
    @current_member = current_user.approval_members.find_by(team_id: @team.id)
  end
end
