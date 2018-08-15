class Users::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_adjustment, only: [:edit, :destroy]
  before_action :set_shift_submission, only: [:new]
  before_action :set_team, only: [:index, :new, :edit, :destroy]
  before_action :set_current_member, only: [:index, :new, :edit, :destroy]
  
  before_action -> { authorize! @current_member }

  def new
  end

  def edit
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

  def set_team
    super
    @team ||= @shift_submission&.team
    @team ||= @shift_adjustment&.team
  end
end
