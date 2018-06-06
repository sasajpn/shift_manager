class Api::V1::Users::Members::UnapprovalsController < Api::V1::Users::ApplicationController

  def create
    @join_team_form = JoinTeamForm.new(join_team_form_params)
    if @join_team_form.save(current_user)
      @success_message = 'チームに参加申請をしました'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @join_team_form.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  private

  def join_team_form_params
    params.require(:join_team_form).permit(
      :identifier, :calendar_color
    )
  end
end
