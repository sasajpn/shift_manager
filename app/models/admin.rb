class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_one :line_connection, as: :account
end
