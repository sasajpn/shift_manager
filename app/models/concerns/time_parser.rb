module TimeParser
  extend ActiveSupport::Concern

  def time_parse(date, time)
    Chronic.parse("#{date} #{time}")
  end

  def time_format(date, time)
    time_parse(date, time).strftime("%-m月%-d日%H時%M分")
  end
end
