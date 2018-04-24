class Admins::ShiftAdjustmentsController < Admins::ApplicationController
  before_action :set_shift_submission, only: [:new]

  def new
    @shift_adjustment = @shift_submission.build_shift_adjustment
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
