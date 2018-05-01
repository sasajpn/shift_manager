class Admins::LineRichmenusController < Admins::ApplicationController

  def index
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

  def destroy
  end

  private

  def line_richmenu_params
    params.fetch(:team, {}).permit(
      :type, :image
    )
  end
end
