class Api::V1::Users::ShiftCoordinators::ShiftTablesController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    @members = @team.members
    @date = params[:date]
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  private

  def have_valid_permission?
    @team.shift_coordinator?(current_user)
  end
end
