class Api::V1::Users::ShiftCoordinators::MembersLoyalty < ApplicationLoyalty
  def update?
    record.manager?(user)
  end
end
