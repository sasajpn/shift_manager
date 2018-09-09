class Shift::Adjustment < Shift
  belongs_to :shift_submission

  has_one :member, through: :shift_submission
  has_one :team, through: :member

  validates :start_time,
            time_format: true,
            time_order: {attr: 'end_time'},
            outside_shift_submission_time: true

  validates :end_time,
            time_format: true,
            outside_shift_submission_time: true

  validates_with OverlapShiftAdjustmentValidator

  after_create :submission_is_approved
  after_destroy :submission_is_unapproved

  scope :adjusted_date, -> date {
    joins(:shift_submission).where("shift_submissions.submitted_date = ?", date)
  }

  def start_time_parse
    time_parse(shift_submission.submitted_date, start_time)
  end

  def end_time_parse
    time_parse(shift_submission.submitted_date, end_time)
  end

  def start_time_format
    time_format(shift_submission.submitted_date, start_time)
  end

  def end_time_format
    time_format(shift_submission.submitted_date, end_time)
  end

  private

  def submission_is_approved
    shift_submission.is_approved
  end

  def submission_is_unapproved
    shift_submission.is_unapproved
  end
end
