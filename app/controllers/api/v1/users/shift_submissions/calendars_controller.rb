class Api::V1::Users::ShiftSubmissions::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:index]

  def index
    @shift_submissions = @member.shift_submissions
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
