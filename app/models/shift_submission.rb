class ShiftSubmission < ApplicationRecord
  belongs_to :member

  has_one :shift_adjustment, dependent: :destroy,
    before_add :approve_submission,
    before_remove :cancel_adjustment

  def is_approved
    self.update(status: 'approve')
  end
end
