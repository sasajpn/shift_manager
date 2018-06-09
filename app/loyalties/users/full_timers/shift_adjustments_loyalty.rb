class Users::FullTimers::ShiftAdjustmentsLoyalty < ApplicationLoyalty
  def index?
    member.full_timer?
  end

  def new?
    member.full_timer?
  end

  def edit?
    member.full_timer?
  end

  def destroy?
  end
end
