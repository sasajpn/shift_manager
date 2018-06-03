class Api::V1::Users::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_shift_submission, only: [:create]

  def new
  end

  def create
    @shift_adjustment = @shift_submission.build_shift_adjustment(shift_adjustment_params)
    @shift_adjustment.attributes = {
      account_type: current_user.model_name.name,
      account_id: current_user.id
    }
    if @shift_adjustment.save
      @success_message = 'シフトを調整しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  def update
    if @shift_adjustment.update(shift_adjustment_params)
      @success_message = 'シフトの調整内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
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
