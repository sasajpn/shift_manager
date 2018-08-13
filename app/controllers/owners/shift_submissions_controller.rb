class Owners::ShiftSubmissionsController < Owners::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index]

  include Owners::AccessControl
  before_action :check_valid_permisson, only: [:index, :show]

  def index
  end

  def show
    @member = @shift_submission.member
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find_by(id: params[:id])
  end
end
