class Users::Managers::TeamsController < Users::ApplicationController
  before_action :set_team, only: [:update_identifier]
  before_action :set_member, only: [:update_identifier]

  include Users::Managers::AccessControl
  before_action :check_valid_permisson, only: [:update_identifier]

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to users_member_url(@member)
    else
      render :show
    end
  end

  private

  def set_team
    @team = Team.find_by(id: params[:id])
  end

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
