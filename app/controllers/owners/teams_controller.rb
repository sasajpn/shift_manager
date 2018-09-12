class Owners::TeamsController < Owners::ApplicationController
  before_action :set_team, only: [:show, :edit, :update_identifier]

  include Owners::AccessControl

  def show
    @unapprovals = @team.members.unapprovals
  end

  def edit
  end

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to owners_team_url(@team)
    else
      render :show
    end
  end
end
