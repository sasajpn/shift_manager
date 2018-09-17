class Users::ShiftCoordinators::Members::UnapprovalsController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index, :show, :edit, :destroy]

  include Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  def destroy
    @member.destroy
    redirect_to users_shift_coordinators_team_members_unapprovals_url(@member.team), flash: { success: 'チームへの参加申請を拒否しました' }
  end

  private

  def have_valid_permission?
    if action_name == 'index'
      @team.manager?(current_user) && @team.active?
    else
      @team.manager?(current_user) && !@member.approve && @team.active?
    end
  end

  def member_params
    params.fetch(:member, {}).permit(
      :role, :approve
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end

  def set_team
    super
    @team ||= @member.team
  end
end
