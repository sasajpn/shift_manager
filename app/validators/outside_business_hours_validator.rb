class OutsideBusinessHoursValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      unless value.between?(record.team.open_time, record.team.close_time)
        record.errors.add(attribute, 'がチームの営業時間外になっています。')
      end
    end
  end
end
