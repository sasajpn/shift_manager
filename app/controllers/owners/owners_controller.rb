class Owners::OwnersController < Owners::ApplicationController

  def edit
  end

  def update
    if current_owner.update(owner_params)
      flash[:success] = '登録内容を変更しました'
      redirect_to edit_owners_owner_url
    else
      render :edit
    end
  end

  def destroy_unconfirmed_email
    current_owner.update(unconfirmed_email: '')
    flash[:success] = 'メールアドレスの変更を取り消しました'
    redirect_to edit_owners_owner_url
  end

  private

  def owner_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end
end
