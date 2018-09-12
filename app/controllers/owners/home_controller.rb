class Owners::HomeController < Owners::ApplicationController

  def index
    @teams = current_owner.teams.order(created_at: :desc).page(params[:page]).per(15)
  end
end
