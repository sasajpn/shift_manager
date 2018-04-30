class Admins::LineConnectionsController < Admins::ApplicationController
  def new
  end

  def create
    @line_connection = current_admin.build_line_connection
    if @line_connection.save
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:link_token]}&nonce=#{@line_connection.nonce}"
    else
      render :new
    end
  end
end
