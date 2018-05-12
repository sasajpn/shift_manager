class TimeFormatValidator < ActiveModel::EachValidator
  REGEXP_36_HOURS = /(^([0-2][0-9]|[3][0-5]):[0-5][0-9]$)|36:00/

  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add(attribute, 'をHH：mmの形式で入力してください。') unless value =~ REGEXP_36_HOURS
    end
  end
end
