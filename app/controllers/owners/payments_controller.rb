class Owners::PaymentsController < Owners::ApplicationController
  before_action :set_team

  def new

  end

  def create
    @team.update_stripe_customer(params[:stripeToken])
    @team.create_stripe_subscription
    redirect_to owners_team_url(@team)
  end
end
