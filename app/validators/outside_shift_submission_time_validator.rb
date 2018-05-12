class OutsideShiftSubmissionTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      unless value.between?(record.shift_submission.start_time, record.shift_submission.end_time)
        record.errors.add(attribute, 'が提出されたシフトの希望時間外になっています')
      end
    end
  end
end
