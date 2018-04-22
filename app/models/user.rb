class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :last_name_kana, :first_name_kana, :last_name, :first_name,
    presence: true
  validates :last_name_kana, katakana_format: true
  validates :first_name_kana, katakana_format: true

end
