module TeamDecorator
  def registerable_count
    max_member_count - members.count
  end
end
