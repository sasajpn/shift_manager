class Shift::Adjustment < Shift
  belongs_to :shift_submission

  has_one :member, through: :shift_submission
  has_one :team, through: :member

  validates :start_time,
    time_format: true,
    time_order: { attr: 'end_time' },
    outside_shift_submission_time: true

  validates :end_time,
    time_format: true,
    outside_shift_submission_time: true

  after_create :submission_is_approved
  after_destroy :submission_is_unapproved

  scope :futures, -> {
    all.select(&:future?)
  }

  scope :adjusted_date, -> date {
    joins(:shift_submission).where("shift_submissions.submitted_date = ?", date)
  }

  scope :full_and_part_timers, -> {
    joins(:member).merge(Member.full_and_part_timers)
  }

  scope :part_timers, -> {
    joins(:member).merge(Member.part_timer)
  }

  def self.access_adjustments(role)
    case role
    when 'part_timer'
      part_timers
    when 'full_timer'
      full_and_part_timers
    when 'manager'
      all
    else
      []
    end
  end

  def end_time_parse
    time_parse(shift_submission.submitted_date, end_time)
  end

  def future?
    end_time_parse > Time.current
  end

  private

  def submission_is_approved
    shift_submission.is_approved
  end

  def submission_is_unapproved
    shift_submission.is_unapproved
  end
end
