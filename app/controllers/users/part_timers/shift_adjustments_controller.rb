class Users::PartTimers::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:new]

  def new
  end

  private
  
  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
