class Api::V1::Owners::ShiftRegistrationsController < Api::V1::Owners::ApplicationController
  before_action :set_shift_registration, only: [:show, :update]
  before_action :set_member, only: [:create]
  before_action :set_team, only: [:create]

  include Api::Owners::AccessControl

  def show
    render json: @shift_registration, only: [:registered_date, :start_time, :end_time]
  end

  def create
    @shift_registration = @member.shift_registrations.build(shift_registration_params)
    @shift_registration.attributes = {
      account_type: current_owner.model_name.name,
      account_id: current_owner.id
    }
    if @shift_registration.save
      flash[:notice] = 'シフトを登録しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_registration.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  def update
    if @shift_registration.update(shift_registration_params)
      flash[:notice] = 'シフトの登録内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @shift_registration.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def shift_registration_params
    params.fetch(:shift_registration, {}).permit(
      :registered_date, :start_time, :end_time
    )
  end

  def set_shift_registration
    @shift_registration = Shift::Registration.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end

  def set_team
    super
    @team ||= @member.team
  end

end
