class Api::V1::Admins::ShiftAdjustmentsController < Api::V1::Admins::ApplicationController
  before_action :set_shift_adjustment, only: [:show]
  before_action :set_shift_submission, only: [:show, :new]

  def show
  end

  def new
  end

  private

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = @shift_adjustment.shift_submission || ShiftSubmission.find(params[:shift_submission_id])
  end
end
