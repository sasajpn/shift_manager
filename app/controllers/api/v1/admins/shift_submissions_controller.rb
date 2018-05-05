class Api::V1::Admins::ShiftSubmissionsController < Api::V1::Admins::ApplicationController
  before_action :set_submission, only: [:edit]
  before_action :set_member, only: [:new]

  def new
    @team = @member.team
  end

  def edit
    @team = @shift_submission.team
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

  def set_member
    @member = Member.find(params[:member_id])
  end
end
