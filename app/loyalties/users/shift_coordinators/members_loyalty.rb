class Users::ShiftCoordinators::MembersLoyalty < Users::ApplicationLoyalty
  def edit?
    team.manager?(user)
  end
end
