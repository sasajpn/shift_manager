class Owners::ShiftSubmissionsController < Owners::ApplicationController
  before_action :set_team, only: [:index, :new, :create]
  before_action :set_shift_submission, only: [:show]

  def index
    @shift_submissions = @team.shift_submissions.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def shift_submission_params
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
