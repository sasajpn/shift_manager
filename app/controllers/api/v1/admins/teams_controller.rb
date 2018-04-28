class Api::V1::Admins::TeamsController < Api::V1::Admins::ApplicationController
  before_action :set_team, only: [:edit]

  def edit
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
