class Users::PartTimers::ShiftRegistrationsLoyalty < ApplicationLoyalty
  def new?
    member.part_timer?
  end

  def edit?
    member.part_timer?
  end
end
