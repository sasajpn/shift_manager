class Api::V1::Users::ShiftCoordinators::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:show, :update]
  before_action :set_team, only: [:show, :update]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, except: [:update]

  def show
    render json: @member, only: [:team_id, :calendar_color, :role, :shift_coordinator]
  end

  def update
    authorize! @team
    if @member.update(member_params)
      flash[:notice] = 'メンバーの設定内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @member.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
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
