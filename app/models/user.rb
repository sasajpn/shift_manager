class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :line_connection, as: :account

  has_many :members, dependent: :destroy
  has_many :teams, through: :members

  validates :last_name_kana, :first_name_kana, :last_name, :first_name,
    presence: true
  validates :last_name_kana, katakana_format: true
  validates :first_name_kana, katakana_format: true

end
