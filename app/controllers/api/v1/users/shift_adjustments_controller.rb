class Api::V1::Users::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :edit]
  before_action :set_shift_submission, only: [:new]

  def new
  end

  private

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
