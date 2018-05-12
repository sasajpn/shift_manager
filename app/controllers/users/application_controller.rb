class Users::ApplicationController < ApplicationController
  layout 'users/application'
  before_action :authenticate_user!

  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_member
    @member = current_user.members.find_by(team_id: @team.id)
  end
end
