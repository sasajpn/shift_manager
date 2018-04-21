class Admins::OwnersController < Admins::ApplicationController
  before_action :set_owner, only: [:show, :edit, :update]

  def index
    @owners = Owner.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(create_params)
    if @owner.save
      redirect_to admins_owners_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @owner.update(update_params)
      redirect_to admins_owner_url(@owner)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def create_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name,
      :email, :password
    )
  end

  def update_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name, :email
    )
  end

  def set_owner
    @owner = Owner.find(params[:id])
  end
end
