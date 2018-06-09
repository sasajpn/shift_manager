class Api::V1::Owners::Teams::CalendarsController < Api::V1::Owners::ApplicationController
  def show
    @shift_submissions = @team.shift_submissions.unapprovals
    @shift_adjustments = @team.shift_adjustments
  end
end
