class Users::ShiftCoordinators::TeamsLoyalty < ApplicationLoyalty
  def update_identifier?
    record.manager?(user)
  end
end
