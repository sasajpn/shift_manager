class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :edit, :update]
  before_action :set_team, only: [:index, :new, :create]
  before_action :set_current_member, only: [:index, :create]
  before_action :set_member, only: [:update]
  before_action -> { authorize! @member }, only: [:update]

  def index
    @shift_submissions = @current_member.shift_submissions
  end

  def show
    render json: @shift_submission, only: [:submitted_date, :start_time, :end_time]
  end

  def new
  end

  def create
    @shift_submission = @current_member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      render :create
    else
      @error_messages = @shift_submission.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def edit
    @team = @shift_submission.team
  end

  def update
    if @shift_submission.update(shift_submission_params)
      render :update
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
    @member = @shift_submission.member
  end
end
