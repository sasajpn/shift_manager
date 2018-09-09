class Users::DeactivationsController < Users::ApplicationController

  def show
  end

  def destroy
    if current_user.destroy
      redirect_to new_user_session_url, notice: '退会しました。ご利用ありがとうございました。'
    else
      redirect_to users_home_index_url, alert: '未来に調整されたシフト、もしくは登録されたシフトが残っているため退会できません。'
    end
  end
end
