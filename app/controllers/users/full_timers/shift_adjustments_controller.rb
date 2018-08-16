class Users::FullTimers::ShiftAdjustmentsController < Users::ApplicationController
  def destroy
    super
    redirect_to users_full_timers_shift_submission_url(@shift_adjustment.shift_submission)
  end
end
