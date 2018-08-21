class Users::ShiftCoordinators::MembersController < Users::ApplicationController
  before_action :set_member, only: [:index, :show, :edit]
  before_action :set_team, only: [:index, :show, :edit]

  include Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:index, :show]

  def index
    member = @team.member(current_user)
    @members = @team.members.access_members(member.role).order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
    authorize! @team
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
