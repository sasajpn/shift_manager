class Users::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index, :show, :new]
  before_action :set_current_member, only: [:index, :show, :new]

  def index
  end

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  def new
  end

  def edit
    @team = @shift_submission.team
  end

  def destroy
    @shift_submission.destroy
    redirect_to users_team_shift_submissions_url(@shift_submission.team)
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

  def set_team
    super
    @team ||= @shift_submission.team
  end
end
