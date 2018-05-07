class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_submission, only: [:edit]
  before_action :set_team, only: [:new, :create]
  before_action :set_member, only: [:create]

  def new
  end

  def create
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      render :create
    else
      @error_messages = @shift_submission.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
    end
  end

  def edit
    @team = @shift_submission.team
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def set_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_member
    @member = @team.members.find_by(user_id: current_user.id)
  end
end
