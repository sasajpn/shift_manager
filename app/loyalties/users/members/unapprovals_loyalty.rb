class Users::Members::UnapprovalsLoyalty < ApplicationLoyalty
  def show?
    user == member.user
  end

  def destroy?
    user == member.user
  end
end
