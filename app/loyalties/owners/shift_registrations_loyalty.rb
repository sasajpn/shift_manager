class Owners::ShiftRegistrationsLoyalty < Owners::ApplicationLoyalty
  def new?
    owner == team.owner
  end

  def edit?
    owner == team.owner
  end
end
