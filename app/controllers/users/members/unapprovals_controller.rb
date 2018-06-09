class Users::Members::UnapprovalsController < Users::ApplicationController
  before_action :set_member, only: [:show, :destroy]
  before_action -> { authorize! @member }, only: [:show, :destroy]

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

  def set_member
    @member = Member.find(params[:id])
  end
end
