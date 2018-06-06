class Users::Managers::MembersLoyalty < ApplicationLoyalty
  def index?
    current_member.manager?
  end

  def show?
    current_member.manager?
  end

  def edit?
    current_member.manager?
  end
end
