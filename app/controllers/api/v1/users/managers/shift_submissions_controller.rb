class Api::V1::Users::Managers::ShiftSubmissionsController < Api::V1::Users::ShiftSubmissionsController
  def index
    @shift_submissions = @team.shift_submissions
  end
end
