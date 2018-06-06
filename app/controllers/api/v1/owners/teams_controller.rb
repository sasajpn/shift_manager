class Api::V1::Owners::TeamsController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:show, :edit, :update]

  def show
    @shift_submissions = @team.shift_submissions.unapprovals
    @shift_adjustments = @team.shift_adjustments
  end

  def create
    @team = current_owner.teams.build(team_params)
    if @team.save
      @success_message = 'チームの登録内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @team.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

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
