class Users::Managers::ShiftRegistrationsLoyalty < Users::ApplicationLoyalty
  def new?
    member&.manager?
  end

  def edit?
    member&.manager?
  end
end
