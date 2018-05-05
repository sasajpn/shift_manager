class Users::TeamsController < Users::ApplicationController

  def index
    @teams = current_user.teams.order(created_at: :desc).page(params[:page]).per(15)
  end
end
