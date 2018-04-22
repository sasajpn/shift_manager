class Member < ApplicationRecord
  belongs_to :team
  belongs_to :user

  enum role: { part_timer: 0, full_timer: 1, manager: 2 }
end
