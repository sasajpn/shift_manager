class Api::V1::Owners::ShiftSubmissionsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:new, :create]

  def new
    @team = @member.team
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      @shift_submission.shift_adjustment.update(
        account_type: current_owner.model_name.name,
        account_id: current_owner.id
      )
      @success_message = 'シフトを登録しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_submission.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time,
      shift_adjustment_attributes: [:start_time, :end_time]
    )
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
