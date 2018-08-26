class Member < ApplicationRecord
  include LuminanceFormula

  belongs_to :team
  belongs_to :user

  has_many :shift_submissions, dependent: :destroy
  has_many :shift_registrations, class_name: 'Shift::Registration'
  has_many :shift_adjustments, through: :shift_submissions, class_name: 'Shift::Adjustment'

  delegate :name, :open_time, :close_time, to: :team, prefix: :team, allow_nil: true

  validates :user_id, :role, :calendar_color,
    presence: true
  validates :user_id,
    uniqueness: { scope: [:team_id], message: 'は既に従業員に登録されています' }

  validates_with MemberMaxCountValidator, on: :update, if: :is_approved?

  enum role: { part_timer: 0, full_timer: 1, manager: 2 }

  scope :approvals, -> {
    where(approve: true)
  }

  scope :unapprovals, -> {
    where(approve: false)
  }

  scope :full_and_part_timers, -> {
    approvals.where(role: [:full_timer, :part_timer])
  }

  scope :part_timers, -> {
    approvals.part_timer
  }


  before_save :set_calendar_font_color
  before_save :become_shift_coordinator

  def self.access_members(role)
    case role
    when 'part_timer'
      part_timers
    when 'full_timer'
      full_and_part_timers
    when 'manager'
      approvals
    else
      []
    end
  end

  def full_time_coordinator?
    full_timer? && shift_coordinator?
  end

  def team_owner
    team.owner
  end

  def is_approved
    self.update(approve: true)
  end

  def is_approved?
    approve_changed?
  end

  private

  def set_calendar_font_color
    if calendar_color_changed?
      self.calendar_font_color = font_color
    end
  end

  def become_shift_coordinator
    if manager?
      self.shift_coordinator = true
    end
  end
end
