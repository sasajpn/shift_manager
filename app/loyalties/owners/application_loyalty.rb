class Owners::ApplicationLoyalty < ApplicationLoyalty
  attr_reader :owner, :team

  def initialize(owner, team)
    @owner = owner
    @team = team
  end
end
