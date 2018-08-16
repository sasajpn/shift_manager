class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:show, :edit]

  include Users::AccessControl
  before_action :check_valid_permisson, only: [:show, :edit]

  def index
    @members = current_user.approval_members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :calendar_color
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    super
    @team ||= @member.team
  end
end
