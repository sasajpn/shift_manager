class ShiftAdjustment < ApplicationRecord
  belongs_to :shift_submission

  has_one :member, through: :shift_submission

  validates :start_time, :end_time,
    presence: true

  validates :start_time,
    time_order: { attr: 'end_time' },
    time_format: true
    
  validates :end_time,
    time_format: true

  after_create :submission_is_approved
  after_destroy :submission_is_unapproved

  private

  def submission_is_approved
    shift_submission.is_approved
  end

  def submission_is_unapproved
    shift_submission.is_unapproved
  end
end
