class Users::Managers::ShiftSubmissionsLoyalty < Users::ApplicationLoyalty
  def index?
    member&.manager?
  end

  def show?
    member&.manager?
  end
end
