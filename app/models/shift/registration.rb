class Shift::Registration < Shift
  belongs_to :member

  has_one :team, through: :member

  validates :registered_date,
    presence: true

  validates_with OverlapShiftRegistrationValidator

  def start_time_parse
    time_parse(registered_date, start_time)
  end

  def end_time_parse
    time_parse(registered_date, end_time)
  end

  def start_time_format
    time_format(registered_date, start_time)
  end

  def end_time_format
    time_format(registered_date, end_time)
  end
end
