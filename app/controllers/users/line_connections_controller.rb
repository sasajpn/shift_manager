class Users::LineConnectionsController < Users::ApplicationController
  layout 'users/login'
  skip_before_action :authenticate_user!

  def new
    @line_connection = CreateLineConnectionForm.new
  end

  def create
    @line_connection = CreateLineConnectionForm.new(create_line_connection_form_params)
    if @line_connection.save
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{@line_connection.nonce}"
    else
      render :new
    end
  end

  private

  def create_line_connection_form_params
    params.require(:create_line_connection_form).permit(:email, :password, :link_token)
  end
end
