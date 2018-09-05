class Owners::Members::UnapprovalsController < Owners::ApplicationController
  before_action :set_member, except: [:index]
  before_action :set_team

  include Owners::AccessControl
  before_action :check_valid_permisson

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
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
end
