class Users::Managers::TeamsLoyalty < Users::ApplicationLoyalty
  def update_identifier?
    member&.manager?
  end
end
