class Users::ApplicationController < ApplicationController
  layout 'users/application'
  before_action :authenticate_user!
  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized(exception)
    loyalty_name = exception.loyalty.class.to_s.underscore

    flash[:error] = t "#{loyalty_name}.#{exception.query}", scope: "banken", default: :default
    redirect_to(request.referrer || users_home_index_url)
  end
end
