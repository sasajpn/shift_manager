class Admins::SessionsController < Devise::SessionsController
  layout 'admins/login'

  private

  def after_sign_in_path_for(resource)
    if params[:linkToken]
      @line_connection = current_admin.create_line_connection
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{@line_connection.nonce}"
    else
      admins_home_index_url
    end
  end

  def after_sign_out_path_for(resource)
    new_admin_session_url
  end
end
