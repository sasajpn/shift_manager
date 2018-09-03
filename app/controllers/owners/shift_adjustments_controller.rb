class Owners::ShiftAdjustmentsController < Owners::ApplicationController
  before_action :set_shift_adjustment, only: [:edit, :destroy]
  before_action :set_shift_submission, only: [:new, :edit]
  before_action :set_team, only: [:new]

  include Owners::AccessControl
  before_action :check_valid_permisson, only: [:new, :edit, :destroy]

  def new
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  def destroy
    @shift_adjustment.destroy
    redirect_to owners_team_url(@shift_adjustment.team)
  end

  private

  def set_shift_adjustment
    @shift_adjustment = Shift::Adjustment.find_by(id: params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find_by(id: params[:shift_submission_id])
  end

  def set_team
    super
    @team ||= @shift_submission.team
  end
end
