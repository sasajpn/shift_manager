class Users::PartTimers::ShiftAdjustmentsLoyalty < Users::ApplicationLoyalty
  def index?
    member&.part_timer?
  end

  def new?
    member&.part_timer?
  end

  def edit?
    member&.part_timer?
  end

  def destroy?
  end
end
