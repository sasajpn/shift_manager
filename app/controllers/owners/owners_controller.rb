class Owners::OwnersController < Owners::ApplicationController

  def edit
  end

  def update
    if current_owner.update(owner_params)
      redirect_to owners_home_index_url
    else
      render :edit
    end
  end

  private

  def owner_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
