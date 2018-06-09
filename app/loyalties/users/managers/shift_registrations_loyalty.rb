class Users::Managers::ShiftRegistrationsLoyalty < ApplicationLoyalty
  def new?
    member.manager?
  end

  def edit?
    member.manager?
  end
end
