module TeamDecorator
  def active_until_format
    active_until.strftime('%Y年%m月%d日')
  end
end
