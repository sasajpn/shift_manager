class Api::V1::Users::PartTimers::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]

  def index
    @shift_adjustments = @team
      .shift_adjustments
      .joins(:member)
      .merge(Member.where(role: :part_timer))
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end
end
