class Users::Managers::ShiftAdjustmentsLoyalty < ApplicationLoyalty
  def index?
    current_member.manager?
  end

  def new?
    current_member.manager?
  end

  def edit?
    current_member.manager?
  end

  def destroy?
  end
end
