class Api::V1::Users::ShiftCoordinators::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :update]
  before_action :set_shift_submission, only: [:create]
  before_action :set_member, only: [:show, :create, :update]
  before_action :set_team, only: [:index, :show, :create, :update]

  include Api::Users::ShiftCoordinators::AccessControl

  def index
    member = @team.member(current_user)
    @shift_adjustments = @team.shift_adjustments.access_shifts(member.role)
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  def show
    render json: @shift_adjustment, only: [:start_time, :end_time]
  end

  def create
    @shift_adjustment = @shift_submission.build_shift_adjustment(shift_adjustment_params)
    @shift_adjustment.attributes = {
      account_type: current_user.model_name.name,
      account_id: current_user.id
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
      account_type: current_user.model_name.name,
      account_id: current_user.id
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

  def set_shift_adjustment
    @shift_adjustment = Shift::Adjustment.find(params[:id])
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:shift_submission_id])
  end

  def set_member
    @member ||= @shift_adjustment&.member
    @member ||= @shift_submission&.member
  end

  def set_team
    super
    @team ||= @member.team
  end
end
