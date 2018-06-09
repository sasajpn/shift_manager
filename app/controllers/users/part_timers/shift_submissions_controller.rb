class Users::PartTimers::ShiftSubmissionsController < Users::ShiftSubmissionsController
  before_action -> { authorize! @current_member }, only: [:show]

  def show
  end
end
