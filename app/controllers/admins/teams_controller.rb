class Admins::TeamsController < Admins::ApplicationController
  before_action :set_team, only: [:show, :edit, :update]
  before_action :set_owner, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @team = @owner.teams.build
  end

  def create
    @team = @owner.teams.build(team_params)
    if @team.save
      redirect_to admins_owner_url(@owner)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to admins_team_url(@team)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def team_params
    params.fetch(:team, {}).permit(
      :name
    )
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def set_owner
    @owner = Owner.find(params[:owner_id])
  end
end
