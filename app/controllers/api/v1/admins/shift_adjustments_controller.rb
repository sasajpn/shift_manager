class Api::V1::Admins::ShiftAdjustmentsController < Api::V1::Admins::ApplicationController
  before_action :set_submission, only: [:new]

  def new
  end

  private

  def set_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
