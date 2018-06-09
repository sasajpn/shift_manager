class Users::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    user == member.user
  end

  def show?
    user == member.user
  end
end
