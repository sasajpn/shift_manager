class Api::V1::Users::ShiftCoordinators::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:show, :update]
  before_action :set_team, only: [:show, :update]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:show]

  def show
    render json: @member, only: [:team_id, :calendar_color]
  end

  def update
    authorize! @team
    if @member.update(member_params)
      @success_message = 'メンバーの設定内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @member.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :role, :shift_coordinator
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = @member.team
  end
end
