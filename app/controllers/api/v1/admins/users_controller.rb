class Api::V1::Admins::UsersController < Api::V1::Admins::ApplicationController

  def index
    @users = User.all
    render 'index', formats: [:json], handlers: [:jbuilder]
  end
end
