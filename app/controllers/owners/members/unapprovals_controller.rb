class Owners::Members::UnapprovalsController < Owners::MembersController
  # before_action -> { authorize! @team }, only: [:index]
  # before_action -> { authorize! @member.team }, only: [:show, :edit, :update, :destroy]

  include Owners::AccessControl

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to owners_team_members_url(@member.team)
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to owners_team_url(@member.team)
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :role, :approve
    )
  end
end
