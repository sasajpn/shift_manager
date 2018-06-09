class Users::FullTimers::ShiftRegistrationsLoyalty < ApplicationLoyalty
  def new?
    current_member.full_timer?
  end

  def edit?
    current_member.full_timer?
  end
end
