class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'users/register'
  protected

  def after_resending_confirmation_instructions_path_for(resource_name)
    root_url
  end
end
