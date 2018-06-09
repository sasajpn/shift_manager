class Users::FullTimers::MembersLoyalty < ApplicationLoyalty
  def index?
    member.full_timer?
  end

  def show?
    member.full_timer?
  end
end
