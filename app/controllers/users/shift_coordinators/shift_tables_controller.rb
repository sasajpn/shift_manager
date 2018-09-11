class Users::ShiftCoordinators::ShiftTablesController < Users::ApplicationController
  before_action :set_team, only: [:index]

  include Users::ShiftCoordinators::AccessControl

  def index

  end
end
