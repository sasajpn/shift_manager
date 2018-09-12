class Admins::ApplicationController < ApplicationController
  layout 'admins/application'
  before_action :authenticate_admin!

  private

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end
end
