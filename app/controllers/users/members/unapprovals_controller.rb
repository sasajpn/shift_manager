class Users::Members::UnapprovalsController < Users::ApplicationController

  def index
    @members = current_user.members.unapprovals.order(created_at: :asc).page(params[:page]).per(15)
  end

  def new
  end
end
