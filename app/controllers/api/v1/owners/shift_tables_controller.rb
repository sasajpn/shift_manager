class Api::V1::Owners::ShiftTablesController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl

  def index
    @members = @team.members
    @date = params[:date]
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
