class Owners::ApplicationController < ApplicationController
  layout 'owners/application'
  before_action :authenticate_owner!

  def current_owner
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def current_user
    current_owner
  end

  private

  def set_team
    @team = Team.find_by(id: params[:id] || params[:team_id])
  end

  def set_member
    @member = Member.find_by(id: params[:id] || params[:member_id])
  end

  def account_not_authorized(exception)
    super
    redirect_to(request.referrer || owners_home_index_url)
  end
end
