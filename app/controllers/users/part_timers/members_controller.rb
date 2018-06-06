class Users::PartTimers::MembersController < Users::MembersController

  def index
    @members = @team
      .members.approvals
      .where.not(user_id: current_user.id)
      .part_timer
      .order(created_at: :desc)
      .page(params[:page]).per(15)
  end
end
