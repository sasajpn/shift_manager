class Users::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_adjustment, only: [:edit, :destroy]
  before_action :set_shift_submission, only: [:new]
  before_action :set_team, only: [:index]
  before_action :set_current_member, only: [:index]

  def index
    authorize! @current_member
  end

  def new
    authorize! @shift_submission.team
  end

  def edit
    authorize! @shift_adjustment.team
    @shift_submission = @shift_adjustment.shift_submission
  end

  def destroy
    @shift_adjustment.destroy
  end

  private

  def set_shift_adjustment
    @shift_adjustment = Shift::Adjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
