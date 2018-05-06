class Api::V1::Users::ShiftSubmissionsController < Api::V1::Users::ApplicationController
  before_action :set_submission, only: [:edit]
  before_action :set_team, only: [:new]

  def new
  end

  def edit
    @team = @shift_submission.team
  end

  private

  def set_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
