module TimeParser
  extend ActiveSupport::Concern

  def time_parse(date, time)
    Chronic.parse("#{date} #{time}")
  end

  def time_format(date, time)
    time_parse(date, time).strftime("%-m月%-d日%H時%M分")
  end

  def min_of_day(time)
    times = time.split(':').map(&:to_i)
    times[0] * 60 + times[1]
  end
end
