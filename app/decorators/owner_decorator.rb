module OwnerDecorator
  def name
    last_name + ' ' + first_name
  end

  def name_kana
    last_name_kana + ' ' + first_name_kana
  end

  def registerable_count
    max_team_count - teams.count
  end
end
