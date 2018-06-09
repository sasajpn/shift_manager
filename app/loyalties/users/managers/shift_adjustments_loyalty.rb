class Users::Managers::ShiftAdjustmentsLoyalty < ApplicationLoyalty
  def index?
    member.manager?
  end

  def new?
    member.manager?
  end

  def edit?
    member.manager?
  end

  def destroy?
  end
end
