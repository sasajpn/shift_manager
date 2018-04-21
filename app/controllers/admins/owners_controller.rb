class Admins::OwnersController < Admins::ApplicationController
  def index
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
      :firstname_kana, :lastname_kana, :firstname, :lastname,
      :email, :password
    )
  end
end
