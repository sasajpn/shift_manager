class Users::RegistrationsController < Devise::RegistrationsController
  layout 'users/register'
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana, :first_name_kana, :last_name, :first_name])
  end

  def after_sign_up_path_for(resource)
    users_home_index_url
  end

  def after_update_path_for(resource)
    users_home_index_url
  end
end
