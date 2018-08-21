class Users::ApplicationLoyalty < ApplicationLoyalty
  attr_reader :user, :member

  def initialize(user,team)
    @user = user
    @team = team
  end
end
