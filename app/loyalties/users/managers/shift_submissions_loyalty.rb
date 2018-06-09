class Users::Managers::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    member&.manager?
  end

  def show?
    member&.manager?
  end
end
