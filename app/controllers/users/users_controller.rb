class Users::UsersController < Users::ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action -> { authorize! @user }, only: [:edit, :update]

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to users_home_index_url
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

  def set_user
    @user = User.find(params[:id])
  end
end
