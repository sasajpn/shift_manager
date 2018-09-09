class ShiftSubmission < ApplicationRecord
  include TimeParser

  belongs_to :member

  has_one :team, through: :member
  has_one :user, through: :member
  has_one :shift_adjustment, class_name: 'Shift::Adjustment',
          dependent: :destroy,
          inverse_of: :shift_submission

  accepts_nested_attributes_for :shift_adjustment

  validates :submitted_date, :start_time, :end_time,
            presence: true

  validates :submitted_date,
            only_after_today: true

  validates :start_time,
            time_format: true,
            time_order: {attr: 'end_time'},
            outside_business_hours: true

  validates :end_time,
            time_format: true,
            outside_business_hours: true

  validates_with OverlapShiftSubmissionValidator

  scope :unapprovals, -> {
    where(approve: false)
  }

  scope :full_and_part_timers, -> {
    joins(:member).merge(Member.full_and_part_timers)
  }

  scope :part_timers, -> {
    joins(:member).merge(Member.part_timer)
  }

  def self.access_submissions(role)
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

  def team_owner
    team.owner
  end

  def is_approved
    self.update(approve: true)
  end

  def is_unapproved
    self.update(approve: false)
  end

  def start_time_parse
    time_parse(submitted_date, start_time)
  end

  def end_time_parse
    time_parse(submitted_date, end_time)
  end

  def start_time_format
    time_format(submitted_date, start_time)
  end

  def end_time_format
    time_format(submitted_date, end_time)
  end

  def start_min_of_day
    min_of_day(start_time)
  end

  def end_min_of_day
    min_of_day(end_time)
  end

  def end_min_of_day_in_table
    end_min_of_day - 10
  end
end
