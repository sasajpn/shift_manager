class Api::V1::Users::TeamsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:show]

  include Api::Users::AccessControl

  def show
    render json: @team, only: [:open_time, :close_time]
  end

  private

  def have_valid_permission?
    @team.member(current_user)
  end
end
