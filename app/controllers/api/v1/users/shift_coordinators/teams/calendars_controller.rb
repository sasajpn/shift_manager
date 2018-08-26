class Api::V1::Users::ShiftCoordinators::Teams::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, only: [:index]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    @shift_submissions = @team.shift_submissions.unapprovals.access_submissions(@member.role)
    @shift_adjustments = @team.shift_adjustments.access_shifts(@member.role)
    @shift_registrations = @team.shift_registrations.access_shifts(@member.role)
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  private

  def set_member
    @member = @team.member(current_user)
  end

  def have_valid_permission?
    @team.shift_coordinator?(current_user)
  end
end
