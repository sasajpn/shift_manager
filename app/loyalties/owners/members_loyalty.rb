class Owners::MembersLoyalty < Owners::ApplicationLoyalty
  def index?
    owner == team.owner
  end

  def show?
    owner == team.owner
  end

  def edit?
    owner == team.owner
  end

  def destroy?
    owner == team.owner
  end
end
