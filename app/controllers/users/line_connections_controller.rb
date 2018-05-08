class Users::LineConnectionsController < Users::ApplicationController
  layout 'users/login'
  skip_before_action :authenticate_user!

  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.valid_password?(params[:password])
      nonce = SecureRandom.urlsafe_base64
      Redis.current.hset(nonce, 'type', 'Admin')
      Redis.current.hset(nonce, 'id', admin.id)
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:linkToken]}&nonce=#{nonce}"
    else
      render :new
    end
  end
end
