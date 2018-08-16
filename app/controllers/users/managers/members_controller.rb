class Users::Managers::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit]
  before_action :set_team, only: [:index, :show, :edit]

  include Users::Managers::AccessControl
  before_action :check_valid_permisson, only: [:index, :show, :edit]

  def index
    @members = @team.members.approvals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
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
