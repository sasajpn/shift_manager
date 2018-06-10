class Users::Managers::MembersLoyalty < Users::ApplicationLoyalty
  def index?
    member&.manager?
  end

  def show?
    member&.manager?
  end

  def edit?
    member&.manager?
  end
end
