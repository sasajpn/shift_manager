class Api::V1::Users::FullTimers::ShiftAdjustmentsController < Api::V1::Users::ShiftAdjustmentsController
  def index
    @shift_adjustments = @team
      .shift_adjustments
      .joins(:member)
      .merge(Member.where(role: [:full_timer, :part_timer]))
  end
end
