class Owners::Members::UnapprovalsController < Owners::ApplicationController
  before_action :set_member, except: [:index]
  before_action :set_team

  include Owners::AccessControl

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

  def set_team
    super
    @team ||= @member.team
  end
end
