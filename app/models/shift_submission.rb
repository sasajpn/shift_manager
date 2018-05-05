class ShiftSubmission < ApplicationRecord
  belongs_to :member

  has_one :team, through: :member
  has_one :shift_adjustment, dependent: :destroy

  scope :non_approved, -> {
    where(approve: false)
  }

  def is_approved
    self.update(approve: true)
  end

  def is_unapproved
    self.update(approve: false)
  end
end
