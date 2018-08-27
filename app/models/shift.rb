class Shift < ApplicationRecord
  self.store_full_sti_class = false

  include TimeParser

  belongs_to :account, polymorphic: true

  validates :start_time, :end_time,
    presence: true

  scope :full_and_part_timers, -> {
    joins(:member).merge(Member.full_and_part_timers)
  }

  scope :part_timers, -> {
    joins(:member).merge(Member.part_timer)
  }

  def self.access_shifts(role)
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

  def account_name
    account.name
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
