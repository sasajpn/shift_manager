class Users::PartTimers::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    member.part_timer?
  end

  def show?
    member.part_timer?
  end
end
