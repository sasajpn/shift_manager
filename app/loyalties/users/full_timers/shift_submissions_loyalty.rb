class Users::FullTimers::ShiftSubmissionsLoyalty < Users::ApplicationLoyalty
  def index?
    member&.full_timer?
  end

  def show?
    member&.full_timer?
  end
end
