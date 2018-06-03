class Users::PartTimers::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:new]
  before_action :set_team, only: [:index]
  before_action :set_current_member, only: [:index]

  def index
    @shift_adjustments = @team
      .shift_adjustments
      .joins(:member)
      .merge(Member.where(role: :part_timer))
  end

  def new
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
