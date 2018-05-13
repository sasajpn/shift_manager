class Owners::ShiftAdjustmentsController < Owners::ApplicationController
  before_action :set_shift_adjustment, only: [:edit]
  before_action :set_shift_submission, only: [:new]

  def index
  end

  def show
  end

  def new
  end

  def edit
    @shift_submission = @shift_adjustment.shift_submission
  end

  def destroy
  end

  private

  def shift_adjustment_params
  end

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
