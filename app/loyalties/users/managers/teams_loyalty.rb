class Users::Managers::TeamsLoyalty < ApplicationLoyalty
  def update_identifier?
    current_member.manager?
  end
end
