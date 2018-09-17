class Api::V1::Owners::TeamsController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:show, :update]

  include Api::Owners::AccessControl
  before_action :check_valid_permisson, except: [:create]

  def show
    render json: @team, only: [:name, :open_time, :close_time]
  end

  def create
    @team = current_owner.teams.build(team_params)
    if @team.save
      flash[:notice] = 'チームを作成しました'
      render json: { status: 200 }
    else
      @error_messages = @team.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  def update
    if @team.update(team_params)
      flash[:notice] = 'チームの登録内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @team.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
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
