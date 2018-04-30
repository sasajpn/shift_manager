class LineConnection < ApplicationRecord
  belongs_to :account, polymorphic: true

  before_create :set_nonce

  private

  def set_nonce
    self.nonce = SecureRandom.urlsafe_base64
  end
end
