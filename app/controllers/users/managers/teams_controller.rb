class Users::Managers::TeamsController < Users::TeamsController
  before_action :set_team, only: [:update_identifier]
  before_action :set_current_member, only: [:update_identifier]
  before_action -> { authorize! @current_member }

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to users_team_url(@team)
    else
      render :show
    end
  end
end
