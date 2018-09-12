class Admins::Members::UnapprovalsController < Admins::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, except: [:index]

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show

  end

  def edit

  end

  def update
    if @member.update(member_params)
      redirect_to admins_team_members_unapprovals_url(@member.team)
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to admins_team_members_unapprovals_url(@member.team)
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
        :role, :approve
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end
end
