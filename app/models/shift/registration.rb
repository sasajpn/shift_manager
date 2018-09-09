class Shift::Registration < Shift
  belongs_to :member

  has_one :team, through: :member

  validates :registered_date,
    presence: true

  def end_time_parse
    time_parse(registered_date, end_time)
  end
end
