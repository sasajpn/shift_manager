class Owners::Members::UnapprovalsController < Owners::MembersController

  include Owners::AccessControl
  before_action :check_valid_permisson, only: [:index, :show, :edit, :update, :destroy]

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

  def have_valid_permission?
    if ['index', 'new', 'create'].include?(action_name)
      @team.owner == current_owner
    else
      @member.team_owner == current_owner
    end
  end

  def member_params
    params.fetch(:member, {}).permit(
      :role, :approve
    )
  end
end
