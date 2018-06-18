class Owners::ShiftSubmissionsLoyalty < Owners::ApplicationLoyalty
  def index?
    owner == team.owner
  end

  def show?
    owner == team.owner
  end
end
