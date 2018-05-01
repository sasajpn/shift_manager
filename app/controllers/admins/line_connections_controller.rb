class Admins::LineConnectionsController < Admins::ApplicationController

  def new
    @line_connection = current_admin.create_line_connection
    redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{@line_connection.nonce}"
  end
end
