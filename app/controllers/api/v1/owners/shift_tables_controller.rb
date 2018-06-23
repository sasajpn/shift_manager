class Api::V1::Owners::ShiftTablesController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl

  def index
    @members = @team.members
    @date = params[:date]
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
