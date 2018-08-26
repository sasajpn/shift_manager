class Api::V1::Users::ShiftCoordinators::Members::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:index]
  before_action :set_team, only: [:index]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
    @shift_registrations = @member.shift_registrations
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  private

  def set_team
    @team = @member.team
  end

  def have_valid_permission?
    @team.shift_coordinator?(current_user)
  end
end
