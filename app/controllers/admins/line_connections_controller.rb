class Admins::LineConnectionsController < Devise::SessionsController

  def new
    if admin_signed_in?
      @line_connection = current_admin.create_line_connection
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:link_token]}&nonce=#{@line_connection.nonce}"
    else
      super
    end
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if admin_signed_in?
      @line_connection = current_admin.create_line_connection
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:link_token]}&nonce=#{@line_connection.nonce}"
    else
      render :new
    end
  end
end
