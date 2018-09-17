class Api::V1::Owners::ShiftAdjustmentsController < Api::V1::Owners::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :update]
  before_action :set_shift_submission, only: [:create]
  before_action :set_team, only: [:create]

  include Api::Owners::AccessControl

  def show
    render json: @shift_adjustment, only: [:start_time, :end_time]
  end

  def create
    @shift_adjustment = @shift_submission.build_shift_adjustment(shift_adjustment_params)
    @shift_adjustment.attributes = {
      account_type: current_owner.model_name.name,
      account_id: current_owner.id
    }
    if @shift_adjustment.save
      flash[:notice] = 'シフトを調整しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  def update
    @shift_adjustment.attributes = {
      account_type: current_owner.model_name.name,
      account_id: current_owner.id
    }
    if @shift_adjustment.update(shift_adjustment_params)
      flash[:notice] = 'シフトの調整内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def shift_adjustment_params
    params.fetch(:shift_adjustment, {}).permit(
      :start_time, :end_time
    )
  end

  def set_team
    super
    @team ||= @shift_submission.team
  end

  def set_shift_adjustment
    @shift_adjustment = Shift::Adjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end
end
