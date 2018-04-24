class Api::V1::Admins::ShiftSubmissionsController < Api::V1::Admins::ApplicationController
  before_action :set_submission, only: [:edit, :update]

  def edit
  end

  def update
    if @shift_submission.update(shift_submission_params)
      head :ok
    end
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def set_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end
end
