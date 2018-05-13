class Owners::PasswordsController < Devise::PasswordsController
  layout 'owners/register'

  protected

  def after_resetting_password_path_for(resource)
    owners_home_index_url
  end
end
