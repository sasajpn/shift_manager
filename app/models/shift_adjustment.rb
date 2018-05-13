class ShiftAdjustment < ApplicationRecord
  belongs_to :shift_submission
  belongs_to :account, polymorphic: true, optional: true

  has_one :member, through: :shift_submission
  has_one :team, through: :member

  validates :start_time, :end_time,
    presence: true

  validates :start_time,
    time_format: true,
    time_order: { attr: 'end_time' },
    outside_shift_submission_time: true

  validates :end_time,
    time_format: true,
    outside_shift_submission_time: true

  after_create :submission_is_approved
  after_destroy :submission_is_unapproved
  after_destroy :destroy_shift_submission

  scope :futures, -> {
    all.select(&:future?)
  }

  def adjusted_end_time
    Chronic.parse("#{shift_submission.submitted_date} #{end_time}")
  end

  def future?
    adjusted_end_time > Time.current
  end

  private

  def submission_is_approved
    shift_submission.is_approved
  end

  def submission_is_unapproved
    shift_submission.is_unapproved
  end

  def destroy_shift_submission
    unless myself
      shift_submission.destroy
    end
  end
end
