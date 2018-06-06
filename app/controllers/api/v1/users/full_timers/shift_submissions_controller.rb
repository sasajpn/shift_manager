class Api::V1::Users::FullTimers::ShiftSubmissionsController < Api::V1::Users::ShiftSubmissionsController
  def index
    @shift_submissions = @team
      .shift_submissions
      .joins(:member)
      .merge(Member.where(role: [:full_timer, :part_timer]))
  end
end
