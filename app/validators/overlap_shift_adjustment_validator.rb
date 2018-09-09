class OverlapShiftAdjustmentValidator < ActiveModel::Validator
  def validate(record)
    unless [record.start_time, record.end_time].include?("")
      overlap_shift_registration = record.member.shift_registrations
                                     .select {|registration| registration.start_time_parse < record.end_time_parse}
                                     .select {|registration| registration.end_time_parse > record.start_time_parse}

      if overlap_shift_registration.any?
        overlap_shift_registration.each do |registration|
          record.errors.add(
              :base,
              "#{registration.start_time_format}〜#{registration.end_time_format}ですでにシフトの登録がされています"
          )
        end
      end
    end
  end
end