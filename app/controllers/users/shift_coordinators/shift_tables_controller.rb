class Users::ShiftCoordinators::ShiftTablesController < Users::ApplicationController
  before_action :set_team

  include Users::ShiftCoordinators::AccessControl

  def index

  end
end
