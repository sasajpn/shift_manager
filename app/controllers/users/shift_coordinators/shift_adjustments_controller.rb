class Users::ShiftCoordinators::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_shift_adjustment, only: [:edit, :destroy]
  before_action :set_shift_submission, only: [:new]
  before_action :set_team, only: [:new, :edit, :destroy]
  before_action :set_member, only: [:new, :edit, :destroy]

  include Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:new, :edit, :destroy]

  def new
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  def destroy
    @shift_adjustment.destroy
    redirect_to users_shift_coordinators_shift_submission_url(@shift_adjustment.shift_submission)
  end

  private

  def set_shift_adjustment
    @shift_adjustment = Shift::Adjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end

  def set_team
    @team = @shift_submission&.team || @shift_adjustment&.team
  end

  def set_member
    @member = @shift_submission&.member || @shift_adjustment&.member
  end
end
