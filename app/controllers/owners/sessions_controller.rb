class Owners::SessionsController < Devise::SessionsController

  private

  def after_sign_in_path_for(resource)
    owners_home_index_url
  end

  def after_sign_out_path_for(resource)
    new_owner_session_url
  end
end
