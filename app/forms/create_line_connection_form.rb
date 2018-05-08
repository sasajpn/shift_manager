class CreateLineConnectionForm
  include ActiveModel::Model

  attr_accessor :email, :password, :link_token,
                :user, :nonce

  validates :email, :password, presence: true
  validate :not_exist_user, :invalid_password

  def save
    set_user
    return false if invalid?
    create_nonce
    true
  end


  private

  def create_nonce
    @nonce = SecureRandom.urlsafe_base64
  end

  def set_user
    @user = User.find_by(email: email)
  end

  def set_nonce
    Redis.current.hset(nonce, 'type', 'User')
    Redis.current.hset(nonce, 'id', user.id)
  end

  def not_exist_user
    if email.present?
      unless user
        errors.add(:email, "が見つかりません")
      end
    end
  end

  def invalid_password
    if password.present?
      unless user && user&.valid_password?(password)
        errors.add(:password, 'が間違っています')
      end
    end
  end
end
