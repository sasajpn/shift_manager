class Api::V1::Users::ShiftCoordinators::ShiftSubmissions::CalendarsController < Users::ApplicationController
  before_action :set_team, only: [:index]

  def index
    member = @team.member(current_user)
    @shift_submissions = @team.shift_submissions.access_submissions(member.role)
  end
end
