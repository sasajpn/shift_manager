class TeamMaxCountValidator < ActiveModel::Validator
  def validate(record)
    owner = record.owner
    team_count = owner.teams.count
    max_team_count = owner.max_team_count

    if team_count >= max_team_count
      record.errors.add(:base, "チームの登録上限数を超しています")
    end
  end
end
