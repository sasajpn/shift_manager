class Users::Members::UnapprovalsController < Users::ApplicationController
  before_action :set_member, only: [:show]

  def index
    @members = current_user.members.unapprovals.order(created_at: :asc).page(params[:page]).per(15)
  end

  def show
    @team = @member.team
  end

  def new
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end
end
