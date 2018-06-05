class Api::V1::Users::Managers::ShiftAdjustmentsController < Api::V1::Users::ShiftAdjustmentsController
  def index
    @shift_adjustments = @team.shift_adjustments
  end
end
