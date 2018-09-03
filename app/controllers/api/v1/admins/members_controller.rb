class Api::V1::Admins::MembersController < Api::V1::Admins::ApplicationController
  before_action :set_team, only: [:create]

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

  private

  def member_params
    params.fetch(:member, {}).permit(
      :user_id, :role, :shift_coordinator, :calendar_color
    )
  end

  def set_team
    @team = Team.find_by(id: params[:team_id])
  end
end
