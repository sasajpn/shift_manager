class Api::V1::Admins::MembersController < Api::V1::Admins::ApplicationController
  before_action :set_member, only: [:show, :update]
  before_action :set_team, only: [:create]

  def show
    render json: @member, only: [:role, :shift_coordinator, :calendar_color]
  end

  def create
    @member = @team.members.build(member_params)
    if @member.save
      @success_message = 'チームを作成しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @member.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def update
    if @member.update(member_params)
      @success_message = 'チームの登録内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @member.errors.full_messages
      render "api/v1/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :user_id, :role, :shift_coordinator, :calendar_color
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end
end
