class Owners::TeamsLoyalty < Owners::ApplicationLoyalty
  def show?
    owner == team.owner
  end
end
