class Users::PartTimers::ShiftAdjustmentsController < Users::ShiftAdjustmentsController
  def destroy
    super
    redirect_to users_part_timers_shift_submission_url(@shift_adjustment.shift_submission)
  end
end
