class Users::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :edit, :destroy]
  before_action :set_member, only: [:index, :show, :new, :edit]
  before_action :set_team, only: [:index, :show, :new, :edit]

  include Users::AccessControl
  before_action :check_valid_permisson, only: [:index, :show, :new, :edit, :destroy]

  def index
  end

  def show
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  def new
  end

  def edit
  end

  def destroy
    @shift_submission.destroy
    redirect_to users_member_shift_submissions_url(@shift_submission.member)
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
    @team ||= @member.team
    @team ||= @shift_submission.team
  end

  def set_member
    super
    @member ||= @shift_submission.member
  end
end
