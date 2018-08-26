class Api::V1::Users::ShiftCoordinators::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_team, only: [:index]

  include Api::Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    member = @team.member(current_user)
    @shift_submissions = @team.shift_submissions.access_submissions(member.role)
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
