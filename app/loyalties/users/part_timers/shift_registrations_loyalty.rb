class Users::PartTimers::ShiftRegistrationsLoyalty < Users::ApplicationLoyalty
  def new?
    member&.part_timer?
  end

  def edit?
    member&.part_timer?
  end
end
