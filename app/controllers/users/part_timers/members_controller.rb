class Users::PartTimers::MembersController < Users::MembersController
  before_action :set_member, only: [:show]
  before_action :set_team, only: [:index, :show]

  include Users::PartTimers::AccessControl
  before_action :check_valid_permisson, only: [:index, :show]

  def index
    @members = @team
      .members.approvals
      .where.not(user_id: current_user.id)
      .part_timer
      .order(created_at: :desc)
      .page(params[:page]).per(15)
  end

  def show
  end

  private

  def set_member
    @member = Member.find_by(id: params[:id])
  end

  def set_team
    super
    @team ||= @member.team
  end
end
