class Users::PartTimers::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index, :show]
  before_action :set_current_member, only: [:index, :show]

  def index
  end

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_team
    super
    @team ||= @shift_submission.team
  end
end
