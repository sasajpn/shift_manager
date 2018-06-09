class Users::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    user == current_member.user
  end

  def show?
    user == current_member.user
  end
end
