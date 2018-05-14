class Users::ShiftCoordinators::MembersController < Users::ApplicationController
  before_action :set_team, only: [:index]

  def index
    @members = @team.members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
