class Shift::Registration < Shift
  belongs_to :member

  has_one :team, through: :member

  validates :registered_date,
    presence: true
end
