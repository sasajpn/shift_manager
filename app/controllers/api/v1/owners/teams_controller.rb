class Api::V1::Owners::TeamsController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:edit, :update]

  def edit
  end

  def update
    if @team.update(team_params)
      render :update
    else
      @error_messages = @team.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def team_params
    params.fetch(:team, {}).permit(
      :name, :open_time, :close_time
    )
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
