class Admins::TeamsController < Admins::ApplicationController
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
  end

  def destroy
  end

  private

  def team_params
    params.fetch(:team, {}).permit(
      :name
    )
  end

  def set_owner
    @owner = Owner.find(params[:owner_id])
  end
end
