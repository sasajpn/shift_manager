class Api::V1::Users::ShiftCoordinators::ShiftAdjustmentsController < Api::V1::Users::ApplicationController
  before_action :set_shift_adjustment, only: [:show, :update]
  before_action :set_shift_submission, only: [:create]
  before_action :set_member, only: [:show, :create, :update]
  before_action :set_team, only: [:index, :show, :create, :update]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    member = @team.member(current_user)
    @shift_adjustments = @team.shift_adjustments.access_adjustments(member.role)
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
      @success_message = 'シフトを調整しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def update
    if @shift_adjustment.update(shift_adjustment_params)
      @success_message = 'シフトの調整内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def set_member
    @member ||= @shift_adjustment&.member
    @member ||= @shift_submission&.member
  end

  def set_team
    super
    @team ||= @member.team
  end
end
