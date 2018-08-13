class Shift < ApplicationRecord
  self.store_full_sti_class = false

  include TimeParser

  belongs_to :account, polymorphic: true

  validates :start_time, :end_time,
    presence: true

  def team_owner
    team.owner
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
