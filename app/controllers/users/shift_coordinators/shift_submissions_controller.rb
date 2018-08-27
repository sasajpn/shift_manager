class Users::ShiftCoordinators::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_member, only: [:show]
  before_action :set_team, only: [:show]

  include Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, only: [:show]

  def show
    @shift_adjustment = @shift_submission.shift_adjustment
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_member
    @member = @shift_submission.member
  end

  def set_team
    @team = @member.team
  end
end
