class Api::V1::Owners::ShiftSubmissionsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:new, :create]

  def new
    @team = @member.team
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    shift_adjustment = @shift_submission.build_shift_adjustment(
      start_time: @shift_submission.start_time,
      end_time: @shift_submission.end_time
    )
    if @shift_submission.valid? && shift_adjustment.valid?
      @shift_submission.save
      shift_adjustment.save
      render :create
    else
      @error_messages = @shift_submission.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
