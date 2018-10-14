class Team < ApplicationRecord
  include TimeParser

  belongs_to :owner

  has_many :members, dependent: :destroy
  has_many :users, through: :member
  has_many :shift_submissions, through: :members
  has_many :shift_adjustments, through: :shift_submissions, class_name: 'Shift::Adjustment'
  has_many :shift_registrations, through: :members, class_name: 'Shift::Registration'

  validates :name, :open_time, :close_time,
    presence: true

  before_create :create_identifier
  before_create :create_stripe_customer
  before_create :active_until_is_next_month

  def member(user)
    members.find_by(user_id: user.id)
  end

  def shift_coordinator?(user)
    member(user)&.shift_coordinator
  end

  def manager?(user)
    member(user)&.manager?
  end

  def full_time_coordinator?(user)
    member(user)&.full_timer? && shift_coordinator?(user)
  end

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

  def create_stripe_customer
    stripe_customer = Stripe::Customer.create(
      email: self.owner.email
    )
    self.stripe_customer_id = stripe_customer.id
  end

  def active_until_is_next_month
    self.active_until = Time.current.next_month.beginning_of_month
  end
end
