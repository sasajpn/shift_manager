class Users::PartTimers::MembersLoyalty < ApplicationLoyalty
  def index?
    member.part_timer?
  end

  def show?
    member.part_timer?
  end

  def edit?
    member.part_timer?
  end
end
