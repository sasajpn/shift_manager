class Users::PartTimers::ShiftRegistrationsLoyalty < ApplicationLoyalty
  def new?
    current_member.part_timer?
  end

  def edit?
    current_member.part_timer?
  end
end
