class Users::ApplicationController < ApplicationController
  layout 'users/application'
  before_action :authenticate_user!

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
