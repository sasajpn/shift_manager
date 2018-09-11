class Api::V1::Owners::Members::UnapprovalsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:update]

  include Api::Owners::AccessControl
  before_action :check_valid_permisson, only: [:update]

  def update
    if @member.update(member_params)
      @success_message = 'メンバーの参加を承認しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @member.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def have_valid_permission?
    @member.team_owner == current_owner && !@member.approve? && @member.team.active?
  end

  def member_params
    params.fetch(:member, {}).permit(
        :approve, :role, :shift_coordinator
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end
end
