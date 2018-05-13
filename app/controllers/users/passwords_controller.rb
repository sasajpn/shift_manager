class Users::PasswordsController < Devise::PasswordsController
  layout 'users/register'

  protected

  def after_resetting_password_path_for(resource)
    users_home_index_url
  end
end
