class Users::SessionsController < Devise::SessionsController
  layout 'users/login'

  private

  def after_sign_in_path_for(resource)
    users_home_index_url
  end

  def after_sign_out_path_for(resource)
    new_user_session_url
  end
end
