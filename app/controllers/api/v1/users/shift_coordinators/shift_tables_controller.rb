class Api::V1::Users::ShiftCoordinators::ShiftTablesController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Users::ShiftCoordinators::AccessControl

  def index
    @members = @team.members
    @date = params[:date]
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
