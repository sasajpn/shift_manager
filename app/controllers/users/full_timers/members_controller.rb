class Users::FullTimers::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show]
  before_action :set_team, only: [:index, :show]

  include Users::FullTimers::AccessControl
  before_action :check_valid_permisson, only: [:index, :show]

  def index
    @members = @team
      .members.approvals
      .where(role: [:full_timer, :part_timer])
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
