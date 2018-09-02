class Api::V1::Users::ShiftCoordinators::Members::UnapprovalsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:update]
  before_action :set_team, only: [:update]

  def update
    if @member.update(member_params)
      @success_message = 'メンバーの参加を承認しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @shift_adjustment.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :approve, :role, :shift_coordinator
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end

  def set_team
    @team ||= @member.team
  end
end
