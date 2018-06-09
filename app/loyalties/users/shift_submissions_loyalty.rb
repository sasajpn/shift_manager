class Users::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    member
  end

  def new?
    member
  end

  def show?
    user == member.user
  end

  def edit?
    user == member.user
  end
end
