module ShiftAdjustmentDecorator
  def adjusted_time
    start_time + '〜' + end_time
  end
end
