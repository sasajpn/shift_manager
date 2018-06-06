class OverlapShiftSubmissionValidator < ActiveModel::Validator
  def validate(record)
    unless [record.submitted_date, record.start_time, record.end_time].include?("")
      overlap_shift_submission = record.member.shift_submissions
        .where.not(id: record.id)
        .select { |shift_submission| shift_submission.start_time_parse < record.end_time_parse }
        .select { |shift_submission| shift_submission.end_time_parse > record.start_time_parse }

      if overlap_shift_submission.any?
        overlap_shift_submission.each do |shift_submission|
          record.errors.add(
            :base,
            "#{shift_submission.start_time_format}〜#{shift_submission.end_time_format}ですでにシフトの希望もしくは調整がされています"
          )
        end
      end
    end
  end
end
