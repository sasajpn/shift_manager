class Users::ApplicationLoyalty < ApplicationLoyalty
  attr_reader :user, :member

  def initialize(user, member)
    @user = user
    @member = member
  end
end
