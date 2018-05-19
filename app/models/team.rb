class Team < ApplicationRecord
  belongs_to :owner

  has_many :members, dependent: :destroy
  has_many :users, through: :member
  has_many :shift_submissions, through: :members
  has_many :shift_adjustments, through: :shift_submissions

  validates :name, :open_time, :close_time,
    presence: true

  validates_with TeamMaxCountValidator

  before_create :create_identifier

  def min_of_day(time)
    times = time.split(':').map(&:to_i)
    times[0] * 60 + times[1]
  end

  def business_hours_every_ten_minutes
    (min_of_day(open_time)...min_of_day(close_time))
    .to_a
    .select { |time| time % 10 == 0 }
  end

  def business_hours_group_by_hour
    business_hours_every_ten_minutes.group_by { |time| time.divmod(60)[0] }
  end

  private

  def create_identifier
    self.identifier = SecureRandom.hex(5)
  end
end
