class Users::TeamsController < Users::ApplicationController
  before_action :set_team, only: [:show]

  def index
    @teams = current_user.teams.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
