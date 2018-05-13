module TimeParser
  extend ActiveSupport::Concern

  def time_parse(date, time)
    Chronic.parse("#{date} #{time}")
  end

  def time_format(date, time)
    time_parse(date, time).strftime("%-m月%-d日%H時%M分")
  end

  def start_time_parse
    time_parse(submitted_date, start_time)
  end

  def start_time_format
    time_format(submitted_date, start_time)
  end

  def end_time_parse
    time_parse(submitted_date, end_time)
  end

  def end_time_format
    time_format(submitted_date, end_time)
  end


end
