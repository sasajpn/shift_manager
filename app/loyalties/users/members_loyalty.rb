class Users::MembersLoyalty < Users::ApplicationLoyalty
  def edit?
    user == member.user
  end
end
