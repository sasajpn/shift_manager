class Owners::Members::UnapprovalsController < Owners::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index]

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to owners_team_members_url(@member.team)
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to owners_team_url(@member.team)
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :role, :approve
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end