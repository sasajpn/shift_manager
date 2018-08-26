class Users::ShiftCoordinators::MembersLoyalty < ApplicationLoyalty
  def edit?
    record.manager?(user)
  end
end
