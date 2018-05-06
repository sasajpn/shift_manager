class Users::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, only: [:index]
  before_action :set_shift_adjustment, only: [:show, :edit, :update, :destroy]
  before_action :set_shift_submission, only: [:new, :create]

  def index
    @shift_adjustments = @member.shift_adjustments.page(params[:page]).per(15)
  end

  def new
    @shift_adjustment = @shift_submission.build_shift_adjustment
  end

  def create
    @shift_adjustment = @shift_submission.build_shift_adjustment(shift_adjustment_params)
    if @shift_adjustment.save
      redirect_to users_shift_submission_url(@shift_submission)
    else
      render :new
    end
  end

  private

  def shift_adjustment_params
    params.fetch(:shift_adjustment, {}).permit(
      :start_time, :end_time
    )
  end

  def set_shift_adjustment
    @shift_adjustment = ShiftAdjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
