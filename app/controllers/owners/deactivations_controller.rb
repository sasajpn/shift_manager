class Owners::DeactivationsController < Owners::ApplicationController

  def show

  end

  def destroy
    if current_owner.destroy
      redirect_to new_owner_session_url, notice: '退会しました。ご利用ありがとうございました。'
    else
      redirect_to owners_home_index_url, alert: '退会できませんでした。管理者にお問い合わせください。'
    end
  end
end
