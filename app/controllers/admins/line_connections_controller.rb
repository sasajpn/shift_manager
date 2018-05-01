class Admins::LineConnectionsController < Admins::ApplicationController

  def new
    if admin_signed_in?
      @line_connection = current_admin.create_line_connection
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{@line_connection.nonce}"
    else
      @admin = Admin.new
    end
  end

  def create
    @line_connection = current_admin.create_line_connection
    redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{@line_connection.nonce}"
  end
end
