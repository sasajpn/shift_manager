class Api::V1::Users::MembersLoyalty < Users::ApplicationLoyalty
  def update?
    user == member.user
  end
end
