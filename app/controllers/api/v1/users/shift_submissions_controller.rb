class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :update]
  before_action :set_member, only: [:create, :update]
  before_action :set_team, only: [:create]

  include Api::Users::AccessControl

  def show
    render json: @shift_submission, only: [:submitted_date, :start_time, :end_time]
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      flash[:notice] = 'シフト希望を提出しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_submission.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  def update
    if @shift_submission.update(shift_submission_params)
      flash[:notice] = 'シフトの提出内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_submission.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_member
    super
    @member ||= @shift_submission.member
  end

  def set_team
    @team = @member.team
  end
end
