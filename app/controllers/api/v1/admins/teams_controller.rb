class Api::V1::Admins::TeamsController < Api::V1::Admins::ApplicationController
  before_action :set_team, only: [:show, :update]
  before_action :set_owner, only: [:create]

  def show
    render json: @team, only: [:name, :open_time, :close_time, :max_member_count]
  end

  def create
    @team = @owner.teams.build(team_params)
    if @team.save
      @success_message = 'チームを作成しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @team.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def update
    if @team.update(team_params)
      @success_message = 'チームの登録内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @team.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def team_params
    params.fetch(:team, {}).permit(
      :name, :open_time, :close_time, :max_member_count
    )
  end

  def set_owner
    @owner = Owner.find_by(id: params[:owner_id])
  end

  def set_team
    @team = Team.find_by(id: params[:id])
  end
end
