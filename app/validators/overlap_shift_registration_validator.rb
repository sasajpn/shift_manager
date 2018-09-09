class OverlapShiftRegistrationValidator < ActiveModel::Validator
  def validate(record)
    unless [record.registered_date, record.start_time, record.end_time].include?("")
      overlap_shift_registration = record.member.shift_registrations
                                       .where.not(id: record.id)
                                       .select {|registration| registration.start_time_parse < record.end_time_parse}
                                       .select {|registration| registration.end_time_parse > record.start_time_parse}

      overlap_shift_submission = record.member.shift_submissions
                                     .select {|submission| submission.start_time_parse < record.end_time_parse}
                                     .select {|submission| submission.end_time_parse > record.start_time_parse}

      if overlap_shift_submission.any? || overlap_shift_registration.any?
        overlap_shift_registration.each do |registration|
          record.errors.add(
              :base,
              "#{registration.start_time_format}〜#{registration.end_time_format}ですでにシフトの登録がされています"
          )
        end
        overlap_shift_submission.each do |submission|
          record.errors.add(
              :base,
              "#{submission.start_time_format}〜#{submission.end_time_format}ですでにシフトの希望がされています"
          )
        end
      end
    end
  end
end