class Admins::LineRichmenusController < Admins::ApplicationController
  before_action :set_line_richmenu, only: [:show, :edit, :update, :destroy]

  def index
    @line_richmenus = LineRichmenu.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def new
    @line_richmenu = LineRichmenu.new
  end

  def create
    @line_richmenu = LineRichmenu.new(line_richmenu_params)
    if @line_richmenu.save
      redirect_to admins_line_richmenus_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @line_richmenu.update(line_richmenu_params)
      redirect_to admins_line_richmenu_url(@line_richmenu)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def line_richmenu_params
    params.fetch(:line_richmenu, {}).permit(
      :type, :richmenu_id, :title, :image
    )
  end

  def set_line_richmenu
    @line_richmenu = LineRichmenu.find(params[:id])
  end
end
