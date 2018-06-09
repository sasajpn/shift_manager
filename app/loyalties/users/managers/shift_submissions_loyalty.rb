class Users::Managers::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    current_member.manager?
  end

  def show?
    current_member.manager?
  end
end
