class Users::PasswordsController < Devise::PasswordsController
  layout 'users/register'

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    root_url
  end
end
