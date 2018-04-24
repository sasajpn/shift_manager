class ShiftSubmission < ApplicationRecord
  belongs_to :member

  has_one :shift_adjustment, dependent: :destroy
end
