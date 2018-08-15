class Users::FullTimers::MembersController < Users::MembersController

  def index
    @members = @team
      .members.approvals
      .where(role: [:full_timer, :part_timer])
      .order(created_at: :desc)
      .page(params[:page]).per(15)
  end

  def show
  end
end
