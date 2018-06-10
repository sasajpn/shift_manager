class Users::PartTimers::MembersLoyalty < Users::ApplicationLoyalty
  def index?
    member&.part_timer?
  end

  def show?
    member&.part_timer?
  end

  def edit?
    member&.part_timer?
  end
end
