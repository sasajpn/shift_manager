class Owners::TeamsLoyalty < Owners::ApplicationLoyalty
  def show?
    owner == team.owner
  end

  def edit?
    owner == team.owner
  end

  def update_identifier?
    owner == team.owner
  end
end
