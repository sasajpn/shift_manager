class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:new]

  def new
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
