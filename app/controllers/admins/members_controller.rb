class Admins::MembersController < Admins::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @member = @team.members.build
  end

  def create
    @member = @team.members.build(create_params)
    if @member.save
      redirect_to admins_team_url(@team)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @member.update(update_params)
      redirect_to admins_member_url(@member)
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to admins_team_url(@member.team)
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

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
