class Api::V1::Users::PartTimers::ShiftSubmissionsController < ApplicationController
  before_action :set_team, only: [:index]

  def index
    @shift_submissions = @team
      .shift_submissions
      .joins(:member)
      .merge(Member.where(role: :part_timer))
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
