class Owners::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_resending_confirmation_instructions_path_for(resource_name)
    owners_home_index_url
  end

  def after_confirmation_path_for(resource_name, resource)
    owners_home_index_url
  end
end
