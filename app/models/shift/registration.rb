class Shift::Registration < Shift
  belongs_to :member

  validates :registered_date,
    presence: true
end
