class Api::V1::Users::TeamsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:show]

  def show
    render json: @team, only: [:open_time, :close_time]
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
