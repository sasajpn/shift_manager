class Owners::Members::UnapprovalsController < Owners::ApplicationController
  before_action :set_team, only: [:index]

  def index
    @members = @team.members.unapprovals.order(created_at: :desc).page(params[:page]).per(15)
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
