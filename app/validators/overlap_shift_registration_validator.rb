class OverlapShiftRegistrationValidator < ActiveModel::Validator
  def validate(record)
    unless [record.registered_date, record.start_time, record.end_time].include?("")
      overlap_shift_registration = record.member.shift_registrations
                                       .where.not(id: record.id)
                                       .select {|registration| registration.start_time_parse < record.end_time_parse}
                                       .select {|registration| registration.end_time_parse > record.start_time_parse}

      overlap_shift_adjustment = record.member.shift_adjustments
                                     .select {|adjustment| adjustment.start_time_parse < record.end_time_parse}
                                     .select {|adjustment| adjustment.end_time_parse > record.start_time_parse}

      if overlap_shift_registration.any? || overlap_shift_adjustment.any?
        overlap_shift_registration.each do |registration|
          record.errors.add(
              :base,
              "#{registration.start_time_format}〜#{registration.end_time_format}ですでにシフトの登録がされています"
          )
        end
        overlap_shift_adjustment.each do |adjustment|
          record.errors.add(
              :base,
              "#{adjustment.start_time_format}〜#{adjustment.end_time_format}ですでにシフトが調整されています"
          )
        end
      end
    end
  end
end