class Users::Managers::ShiftAdjustmentsController < Users::ShiftAdjustmentsController
  def destroy
    super
    redirect_to users_managers_shift_submission_url(@shift_adjustment.shift_submission)
  end
end
