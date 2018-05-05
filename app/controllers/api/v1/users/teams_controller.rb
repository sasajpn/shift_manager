class Api::V1::Users::TeamsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:show]
  before_action :set_member, only: [:show]

  def show
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
