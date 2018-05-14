class Users::ShiftCoordinators::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_adjustment, only: [:edit, :destroy]
  before_action :set_shift_submission, only: [:new]

  def new
    @shift_adjustment = @shift_submission.build_shift_adjustment
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  private

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
