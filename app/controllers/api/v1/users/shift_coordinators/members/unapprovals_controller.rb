class Api::V1::Users::ShiftCoordinators::Members::UnapprovalsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:update]
  before_action :set_team, only: [:update]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson

  def update
    if @member.update(member_params)
      flash[:notice] = 'メンバーの参加を承認しました'
      render json: { status: 200 }
    else
      @error_messages = @member.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def have_valid_permission?
    @team.manager?(current_user) && !@member.approve && @team.active?
  end

  def member_params
    params.fetch(:member, {}).permit(
      :approve, :role, :shift_coordinator
    )
  end

  def set_team
    @team ||= @member.team
  end
end
