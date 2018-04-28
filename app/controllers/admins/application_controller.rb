class Admins::ApplicationController < ApplicationController
  layout 'admins/application'
  before_action :authenticate_admin!

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
