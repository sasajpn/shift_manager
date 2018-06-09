class Users::UsersController < Users::ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_users_user_url
    else
      render :edit
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
