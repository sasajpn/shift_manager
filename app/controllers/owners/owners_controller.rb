class Owners::OwnersController < Owners::ApplicationController

  def edit
  end

  def update
    if current_owner.update(owner_params)
      redirect_to edit_owners_owner_url, flash: { success: '登録内容を変更しました' }
    else
      render :edit
    end
  end

  def destroy_unconfirmed_email
    current_owner.update(unconfirmed_email: '')
    redirect_to edit_owners_owner_url, flash: { success: 'メールアドレスの変更を取り消しました' }
  end

  private

  def owner_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
