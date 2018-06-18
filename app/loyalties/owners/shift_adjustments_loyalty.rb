class Owners::ShiftAdjustmentsLoyalty < Owners::ApplicationLoyalty
  def index?
    owner == team.owner
  end

  def new?
    owner == team.owner
  end

  def edit?
    owner == team.owner
  end

  def destroy?
    owner == team.owner
  end
end
