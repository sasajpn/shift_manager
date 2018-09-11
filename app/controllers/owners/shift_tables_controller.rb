class Owners::ShiftTablesController < Owners::ApplicationController
  before_action :set_team, only: [:index]

  include Owners::AccessControl

  def index
  end
end
