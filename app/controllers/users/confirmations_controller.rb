class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'users/register'
  protected

  def after_resending_confirmation_instructions_path_for(resource_name)
    new_user_session_url
  end

  def after_confirmation_path_for(resource_name, resource)
    users_home_index_url
  end
end
