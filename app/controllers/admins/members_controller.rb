class Admins::MembersController < Admins::ApplicationController
  before_action :set_team, only: [:new, :create]

  def index
  end

  def show
  end

  def new
  end

  def create
    @member = @team.members.build(create_params)
    if @owner.save
      redirect_to admins_owners_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @owner.update(update_params)
      redirect_to admins_owner_url(@owner)
    else
      render :edit
    end
  end

  def destroy
    
  end

  private

  def create_params
    params.fetch(:member, {}).permit(
      :user_id, :role
    )
  end

  def update_params
    params.fetch(:member, {}).permit(
      :role
    )
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
