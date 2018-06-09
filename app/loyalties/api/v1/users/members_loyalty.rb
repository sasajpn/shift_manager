class Api::V1::Users::MembersLoyalty < ApplicationLoyalty
  def update?
    user == member.user
  end
end
