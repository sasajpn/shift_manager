class Api::V1::Owners::TeamsLoyalty < Owners::ApplicationLoyalty
  def show?
    owner == team.owner
  end

  def update?
    owner == team.owner
  end
end
