class Users::PartTimers::ShiftAdjustmentsLoyalty < ApplicationLoyalty
  def index?
    current_member.part_timer?
  end

  def new?
    current_member.part_timer?
  end

  def edit?
    current_member.part_timer?
  end

  def destroy?
  end
end
