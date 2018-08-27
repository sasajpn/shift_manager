class Users::ShiftCoordinators::MembersLoyalty < ApplicationLoyalty
  def edit?
    record.manager?(user)
  end

  def destroy?
    record.manager?(user)
  end
end
