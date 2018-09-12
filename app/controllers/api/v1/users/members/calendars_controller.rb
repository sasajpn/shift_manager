class Api::V1::Users::Members::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_member

  include Api::Users::AccessControl

  def index
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
    @shift_registrations = @member.shift_registrations
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
