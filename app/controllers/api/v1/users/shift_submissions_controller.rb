class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :update]
  before_action :set_member, only: [:index, :create, :update]
  before_action :set_team, only: [:index, :create]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:show, :create, :update]

  def index
    @shift_submissions = @member.shift_submissions
  end

  def show
    render json: @shift_submission, only: [:submitted_date, :start_time, :end_time]
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      @success_message = 'シフト希望を作成しました'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_submission.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def update
    if @shift_submission.update(shift_submission_params)
      @success_message = 'シフト希望を更新しました'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
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
