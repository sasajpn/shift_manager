class Users::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index, :new]
  before_action :set_member, only: [:index, :new]

  def index
    @shift_submissions = @member.shift_submissions.order(submitted_date: :desc).page(params[:page]).per(15)
  end

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  def new
    @shift_submission = @member.shift_submissions.build
  end

  def edit
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

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
