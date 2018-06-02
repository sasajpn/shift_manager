class Api::V1::Users::Teams::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, only: [:index]

  def index
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
