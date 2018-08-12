class Member < ApplicationRecord
  include LuminanceFormula

  belongs_to :team
  belongs_to :user

  has_many :shift_submissions, dependent: :destroy
  has_many :shift_registrations, class_name: 'Shift::Registration'
  has_many :shift_adjustments, through: :shift_submissions, class_name: 'Shift::Adjustment'

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

  before_save :set_calendar_font_color
  before_save :become_shift_coordinator

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
