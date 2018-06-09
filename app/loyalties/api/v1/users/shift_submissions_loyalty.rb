class Api::V1::Users::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def update?
    user == member.user
  end
end
