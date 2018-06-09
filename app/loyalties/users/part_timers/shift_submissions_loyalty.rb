class Users::PartTimers::ShiftSubmissionsLoyalty < ApplicationLoyalty
  def index?
    current_member.part_timer?
  end

  def show?
    current_member.part_timer?
  end
end
