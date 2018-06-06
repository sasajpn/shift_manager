class Users::Managers::TeamsController < Users::TeamsController
  before_action :set_team, only: [:update_identifier]

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to users_team_url(@team)
    else
      render :show
    end
  end
end
