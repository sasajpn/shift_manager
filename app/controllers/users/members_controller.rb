class Users::MembersController < Users::ApplicationController

  def new
  end

  def create
    team = Team.find_by(identifier: params[:identifier])
    if team
      current_user.members.create(team_id: team)
      redirect_to users_teams_url
    else
      render :new
    end
  end

  private

end
