class Admins::UsersController < Admins::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @members = @user.approval_members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      redirect_to admins_users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(update_params)
      redirect_to admins_user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_url
  end

  private

  def create_params
    params.fetch(:user, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name,
      :email, :password
    )
  end

  def update_params
    params.fetch(:user, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
