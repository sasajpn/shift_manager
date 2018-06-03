class Team < ApplicationRecord
  include TimeParser

  belongs_to :owner

  has_many :members, dependent: :destroy
  has_many :users, through: :member
  has_many :shift_submissions, through: :members
  has_many :shift_adjustments, through: :shift_submissions, class_name: 'Shift::Adjustment'

  validates :name, :open_time, :close_time,
    presence: true

  validates_with TeamMaxCountValidator, on: :create

  before_create :create_identifier

  def open_min_of_day
    min_of_day(open_time)
  end

  def close_min_of_day
    min_of_day(close_time)
  end

  def business_hours_every_ten_minutes
    (open_min_of_day...close_min_of_day)
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
