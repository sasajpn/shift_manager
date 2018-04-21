class Admins::OwnersController < Admins::ApplicationController
  before_action :set_owner, only: [:show, :edit]

  def index
    @owners = Owner.all
  end

  def show
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to admins_owners_url
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def owner_params
    params.fetch(:owner, {}).permit(
      :first_name_kana, :last_name_kana, :first_name, :last_name,
      :email, :password
    )
  end

  def set_owner
    @owner = Owner.find(params[:id])
  end
end
