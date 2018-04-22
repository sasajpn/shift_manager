class KatakanaFormatValidator < ActiveModel::EachValidator
  REGEXP_KATAKANA = /^[ァ-ンー－]+$/

  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add(attribute, 'をカタカナで入力してください。') unless value =~ REGEXP_KATAKANA
    end
  end
end
