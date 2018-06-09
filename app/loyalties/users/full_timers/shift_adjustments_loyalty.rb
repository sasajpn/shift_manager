class Users::FullTimers::ShiftAdjustmentsLoyalty < ApplicationLoyalty
  def index?
    current_member.full_timer?
  end

  def new?
    current_member.full_timer?
  end

  def edit?
    current_member.full_timer?
  end

  def destroy?
  end
end
