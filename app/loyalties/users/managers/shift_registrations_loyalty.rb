class Users::Managers::ShiftRegistrationsLoyalty < ApplicationLoyalty
  def new?
    current_member.manager?
  end

  def edit?
    current_member.manager?
  end
end
