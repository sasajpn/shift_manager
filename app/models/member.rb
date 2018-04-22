class Member < ApplicationRecord
  belongs_to :team
  belongs_to :user

  validates :user_id, :role,
    presence: true
  validates :user_id,
    uniqueness: { scope: [:team_id], message: 'は既に従業員に登録されています' }

  enum role: { part_timer: 0, full_timer: 1, manager: 2 }
end
