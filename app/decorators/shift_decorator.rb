module ShiftDecorator
  def adjusted_time
    start_time + '〜' + end_time
  end

  def registered_date_format
    registered_date.strftime('%Y年%m月%d日')
  end

  def registered_time
    start_time + '〜' + end_time
  end
end
