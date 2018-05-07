class Api::V1::Users::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :edit]
  before_action :set_shift_submission, only: [:new, :create]

  def new
  end

  def create
    @shift_adjustment = @shift_submission.build_shift_adjustment(shift_adjustment_params)
    if @shift_adjustment.save
      render :create
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def shift_adjustment_params
    params.fetch(:shift_adjustment, {}).permit(
      :start_time, :end_time
    )
  end

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
