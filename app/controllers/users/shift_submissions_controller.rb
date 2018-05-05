class Users::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index, :new, :create]
  before_action :set_member, only: [:index, :new, :create]

  def index
    @shift_submissions = @member.shift_submissions.order(submitted_date: :desc).page(params[:page]).per(15)
  end

  def show
    @member = @shift_submission.member
  end

  def new
    @shift_submission = @member.shift_submissions.build
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      redirect_to users_team_url(@team)
    else
      render :new
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
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
