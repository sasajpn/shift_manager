class Users::Managers::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    record.manager?
  end

  def show?
    record.manager?
  end
end
