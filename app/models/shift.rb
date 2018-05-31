class Shift < ApplicationRecord
  belongs_to :member
  belongs_to :shift_submission
end
