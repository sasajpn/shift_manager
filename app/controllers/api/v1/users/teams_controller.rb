class Api::V1::Users::TeamsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:show]
  before_action :set_member, only: [:show]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:show]

  def show
    render json: @team, only: [:open_time, :close_time]
  end

  private

  def have_valid_permission?
    @team.member(current_user) ? true : false
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
