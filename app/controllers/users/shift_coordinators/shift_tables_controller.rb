class Users::ShiftCoordinators::ShiftTablesController < Users::ApplicationController
  before_action :set_team, only: [:index]

  def index

  end

  private

  def have_valid_permission?
    @team.shift_coordinator?(current_user)
  end
end
