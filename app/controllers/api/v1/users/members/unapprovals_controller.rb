class Api::V1::Users::Members::UnapprovalsController < Api::V1::Users::ApplicationController

  def create
    @join_team_form = JoinTeamForm.new(join_team_form_params)
    if @join_team_form.save(current_user)
      flash[:notice] = '参加を申請しました'
      render json: { status: 200 }
    else
      @error_messages = @join_team_form.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def join_team_form_params
    params.require(:join_team_form).permit(
      :identifier, :calendar_color
    )
  end
end
