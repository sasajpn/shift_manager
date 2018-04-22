class Team < ApplicationRecord
  belongs_to :owner

  has_many :members, dependent: :destroy
  has_many :users, through: :member

  validates :name,
    presence: true

  before_create :create_identifier

  private

  def create_identifier
    self.identifier = SecureRandom.hex(5)
  end
end
