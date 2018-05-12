class Owners::TeamsController < Owners::ApplicationController
  before_action :set_team, only: [:show, :edit]

  def index
    @teams = current_owner.teams.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
