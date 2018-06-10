class Api::V1::Owners::Teams::CalendarsController < Api::V1::Owners::ApplicationController
  before_action :set_team, only: [:index]

  def index
    @shift_submissions = @team.shift_submissions.unapprovals
    @shift_adjustments = @team.shift_adjustments
    @shift_registrations = @team.shift_registrations
  end
end
