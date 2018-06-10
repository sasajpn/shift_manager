class Owners::TeamsController < Owners::ApplicationController
  before_action :set_team, only: [:show, :edit, :update_identifier]
  before_action -> { authorize! @team }, only: [:show, :edit, :update_identifier]

  def index
    @teams = current_owner.teams.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @unapproved_members = @team.members.unapprovals
    @members = @team.members.approvals.order(created_at: :asc).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to owners_team_url(@team)
    else
      render :show
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
