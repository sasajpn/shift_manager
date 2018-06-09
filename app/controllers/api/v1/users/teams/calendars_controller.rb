class Api::V1::Users::Teams::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_current_member, only: [:index]

  def index
    @shift_submissions = @current_member.shift_submissions.unapprovals
    @shift_adjustments = @current_member.shift_adjustments
    @shift_registrations = @current_member.shift_registrations
  end

  private
end
