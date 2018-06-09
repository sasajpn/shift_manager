class Users::FullTimers::MembersLoyalty < ApplicationLoyalty
  def index?
    current_member.full_timer?
  end

  def show?
    current_member.full_timer?
  end
end
