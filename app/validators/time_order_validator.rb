class TimeOrderValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && value > record.attributes[options[:attr]]
      record.errors.add(attribute, options[:message] || 'は終了時間よりも前に設定してください')
    end
  end
end
