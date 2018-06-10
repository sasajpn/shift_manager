class Api::V1::Users::ShiftSubmissionsLoyalty < Users::ApplicationLoyalty
  def update?
    user == member.user
  end
end
