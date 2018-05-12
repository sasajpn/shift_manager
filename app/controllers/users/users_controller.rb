class Users::UsersController < Users::ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to users_home_index_url
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
