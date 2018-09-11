module TeamDecorator
  def active_until_format
    active_until.strftime('%Y年%m月%d日')
  end

  def registerable_count
    max_member_count - members.approvals.count
  end
end
