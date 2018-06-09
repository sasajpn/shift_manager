class Users::PartTimers::MembersLoyalty < ApplicationLoyalty
  def index?
    current_member.part_timer?
  end

  def show?
    current_member.part_timer?
  end

  def edit?
    current_member.part_timer?
  end
end
