class Api::V1::Owners::ShiftSubmissionsController < Api::V1::Owners::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl

  def index
    @shift_submissions = @team.shift_submissions
  end

  def show
    render json: @shift_submission, only: [:submitted_date, :start_time, :end_time]
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end
end
