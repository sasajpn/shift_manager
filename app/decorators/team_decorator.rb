module TeamDecorator
  def registerable_count
    max_member_count - members.approvals.count
  end
end
