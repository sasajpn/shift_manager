class Users::PartTimers::ShiftSubmissionsLoyalty < Users::ApplicationLoyalty
  def index?
    member&.part_timer?
  end

  def show?
    member&.part_timer?
  end
end
