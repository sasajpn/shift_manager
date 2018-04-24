module ShiftSubmissionDecorator
  def submitted_date_format
    submitted_date.strftime('%Y年%m月%d日')
  end

  def submitted_time
    start_time + '〜' + end_time
  end
end
