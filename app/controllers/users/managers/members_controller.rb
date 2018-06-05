class Users::Managers::MembersController < Users::MembersController

  def index
    @members = @team.members.approvals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
  end
end
