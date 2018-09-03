class Owners::ShiftTablesController < Owners::ApplicationController
  before_action :set_team, only: [:index]

  include Owners::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
  end

  private

  def have_valid_permission?
    @team.owner == current_owner
  end
end
