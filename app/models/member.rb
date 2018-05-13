class Member < ApplicationRecord
  include LuminanceFormula

  belongs_to :team
  belongs_to :user

  has_many :shift_submissions, dependent: :destroy
  has_many :shift_adjustments, through: :shift_submissions

  validates :user_id, :role, :calendar_color,
    presence: true
  validates :user_id,
    uniqueness: { scope: [:team_id], message: 'は既に従業員に登録されています' }

  enum role: { part_timer: 0, full_timer: 1, manager: 2 }

  scope :approvals, -> {
    where(approve: true)
  }

  scope :unapprovals, -> {
    where(approve: false)
  }

  before_save :set_calendar_font_color

  def is_approved
    self.update(approve: true)
  end

  private

  def set_calendar_font_color
    if calendar_color_changed?
      self.calendar_font_color = font_color
    end
  end
end
