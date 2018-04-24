class Admins::ShiftSubmissionsController < Admins::ApplicationController
  before_action :set_shift_submission, only: [:show, :edit, :update, :destroy]
  before_action :set_member, only: [:new, :create]

  def index
  end

  def show
    @member = @shift_submission.member
  end

  def new
    @shift_submission = @member.shift_submissions.build
  end

  def create
    raise
    @shift_submission = @member.shift_submissions.build(shift_submission_params)
    if @shift_submission.save
      redirect_to admins_member_url(@member)
    else
      render :new
    end
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private

  def shift_submission_params
    params.fetch(:shift_submission, {}).permit(
      :submitted_date, :start_time, :end_time
    )
  end

  def update_params
    params.fetch(:shift_submission, {}).permit(
      :status
    )
  end

  def set_shift_submission
    @shift_submission = ShiftSubmission.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
