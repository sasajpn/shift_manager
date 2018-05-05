class Users::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_team, only: [:new]
  before_action :set_member, only: [:new]

  def new
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
