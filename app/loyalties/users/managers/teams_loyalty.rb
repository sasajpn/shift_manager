class Users::Managers::TeamsLoyalty < ApplicationLoyalty
  def update_identifier?
    member&.manager?
  end
end
