class Api::V1::Users::PartTimers::ShiftAdjustmentsController < Api::V1::Users::ShiftAdjustmentsController
  def index
    @shift_adjustments = @team
      .shift_adjustments
      .joins(:member)
      .merge(Member.where(role: :part_timer))
  end
end
