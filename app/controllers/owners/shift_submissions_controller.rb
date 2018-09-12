class Owners::ShiftSubmissionsController < Owners::ApplicationController
  before_action :set_shift_submission, only: [:show]

  include Owners::AccessControl

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find_by(id: params[:id])
  end
end
