class Api::V1::Users::ShiftSubmissions::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:index]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:index]

  def index
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  private

  def have_valid_permission?
    @member.user == current_user
  end
end
