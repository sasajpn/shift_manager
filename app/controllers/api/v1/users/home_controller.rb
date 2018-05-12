class Api::V1::Users::HomeController < ApplicationController

  def index
    @members = current_user.members
  end
end
