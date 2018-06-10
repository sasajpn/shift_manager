class Users::FullTimers::ShiftRegistrationsLoyalty < Users::ApplicationLoyalty
  def new?
    member&.full_timer?
  end

  def edit?
    member&.full_timer?
  end
end
