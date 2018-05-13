class Owners::ShiftAdjustmentsController < Owners::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :edit, :destroy]
  before_action :set_shift_submission, only: [:new]
  before_action :set_team, only: [:index]

  def index
    @shift_adjustments = @team.shift_adjustments.page(params[:page]).per(15)
  end

  def show
    @member = @shift_adjustment.member
  end

  def new
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  def destroy
    @shift_adjustment.destroy
    redirect_to owners_shift_submission_url(@shift_adjustment.shift_submission)
  end

  private

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
