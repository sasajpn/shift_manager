class Api::V1::Users::Members::CalendarsController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:index]

  def show
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
    @shift_registrations = @member.shift_registrations
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end
end
