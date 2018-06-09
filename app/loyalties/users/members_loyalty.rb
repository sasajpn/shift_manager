class Users::MembersLoyalty < ApplicationLoyalty
  def edit?
    user == member.user
  end
end
