class Admins::SessionsController < Devise::SessionsController
  layout 'admins/login'

  private

  def after_sign_in_path_for(resource)
    admins_dashboard_url
  end

  def after_sign_out_path_for(resource)
    new_admin_session_url
  end
end
