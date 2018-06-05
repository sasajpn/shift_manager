class Api::V1::Users::PartTimers::ShiftSubmissionsController < Api::V1::Users::ShiftSubmissionsController
  def index
    @shift_submissions = @team
      .shift_submissions
      .joins(:member)
      .merge(Member.where(role: :part_timer))
  end
end
