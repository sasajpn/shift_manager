class Api::V1::Users::HomeController < Api::V1::Users::ApplicationController

  def index
    @members = current_user.approval_members
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
