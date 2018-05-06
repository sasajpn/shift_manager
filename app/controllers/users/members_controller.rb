class Users::MembersController < Users::ApplicationController

  def new
    @member = JoinTeamForm.new
  end

  def create
    @member = JoinTeamForm.new(join_team_form_params)
    if @member.save(current_user)
      redirect_to users_teams_url
    else
      render :new
    end
  end

  private

  def join_team_form_params
    params.require(:join_team_form).permit(:identifier)
  end

end
