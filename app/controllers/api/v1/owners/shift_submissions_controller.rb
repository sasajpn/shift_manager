class Api::V1::Owners::ShiftSubmissionsController < Api::V1::Owners::ApplicationController
  before_action :set_shift_submission, only: [:show]
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl
  before_action :check_valid_permisson, only: [:index, :show]

  def index
    @shift_submissions = @team.shift_submissions
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  def show
    render json: @shift_submission, only: [:submitted_date, :start_time, :end_time]
  end

  private

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end
end
