class Users::Members::UnapprovalsController < Users::ApplicationController
  before_action :set_member, only: [:show, :destroy]

  include Users::AccessControl
  before_action :check_valid_permisson, only: [:show, :destroy]

  def index
    @members = current_user.unapproval_members.order(created_at: :asc).page(params[:page]).per(15)
  end

  def show
    @team = @member.team
  end

  def new
  end

  def destroy
    @member.destroy
    redirect_to users_members_unapprovals_url
  end

  private

  def have_valid_permission?
    @member.user == current_user
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
