class Api::V1::Owners::ShiftRegistrationsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:create]

  def create
    @shift_registration = @member.shift_registrations.build(shift_registration_params)
    @shift_registration.attributes = {
      account_type: current_owner.model_name.name,
      account_id: current_owner.id
    }
    if @shift_registration.save
      @success_message = 'シフトを登録しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_registration.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def shift_registration_params
    params.fetch(:shift_registration, {}).permit(
      :registered_date, :start_time, :end_time
    )
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
