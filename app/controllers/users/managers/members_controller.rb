class Users::Managers::MembersController < Users::MembersController

  def index
    super
    @members = @team.members.approvals.order(created_at: :desc).page(params[:page]).per(15)
  end
end
