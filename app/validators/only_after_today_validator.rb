class OnlyAfterTodayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      if value < Date.yesterday
        record.errors.add(attribute, 'は今日以降で選択してください')
      end
    end
  end
end
