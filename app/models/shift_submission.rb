class ShiftSubmission < ApplicationRecord
  belongs_to :member

  has_one :team, through: :member
  has_one :user, through: :member
  has_one :shift_adjustment, dependent: :destroy, inverse_of: :shift_submission

  accepts_nested_attributes_for :shift_adjustment

  validates :submitted_date, :start_time, :end_time,
    presence: true

  validates :submitted_date,
    only_after_today: true

  validates :start_time,
    time_format: true,
    time_order: { attr: 'end_time' },
    outside_business_hours: true

  validates :end_time,
    time_format: true,
    outside_business_hours: true

  scope :unapprovals, -> {
    where(approve: false)
  }

  def is_approved
    self.update(approve: true)
  end

  def is_unapproved
    self.update(approve: false)
  end
end
