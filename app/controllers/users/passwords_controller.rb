class Users::PasswordsController < Devise::PasswordsController
  layout 'users/register'

  protected

  def after_resetting_password_path_for(resource)
    users_home_index_url
  end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
