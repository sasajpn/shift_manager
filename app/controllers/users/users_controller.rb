class Users::UsersController < Users::ApplicationController
  
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_users_user_url, flash: { success: '登録内容を変更しました' }
    else
      render :edit
    end
  end

  def destroy_unconfirmed_email
    current_user.update(unconfirmed_email: '')
    redirect_to edit_users_user_url, flash: { success: 'メールアドレスの変更を取り消しました' }
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
