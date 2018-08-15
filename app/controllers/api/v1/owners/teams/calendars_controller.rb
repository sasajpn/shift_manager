class Api::V1::Owners::Teams::CalendarsController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    @shift_submissions = @team.shift_submissions.unapprovals
    @shift_adjustments = @team.shift_adjustments
    @shift_registrations = @team.shift_registrations
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
