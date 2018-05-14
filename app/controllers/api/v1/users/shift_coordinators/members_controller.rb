class Api::V1::Users::ShiftCoordinators::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:show]

  def show
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
