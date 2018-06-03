class Users::PartTimers::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index]
  before_action :set_current_member, only: [:index]

  def index
    @shift_submissions = @team
      .shift_submissions
      .joins(:member)
      .merge(Member.where(role: :part_timer))
      .order(created_at: :desc)
      .page(params[:page]).per(15)
  end

  def show
    @team = @shift_submission.team
    @member = @shift_submission.member
    @current_member = @team.members.find_by(user_id: current_user.id)
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end
end
