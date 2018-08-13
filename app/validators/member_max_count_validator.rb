class MemberMaxCountValidator < ActiveModel::Validator
  def validate(record)
    team = record.team
    member_count = team.members.count
    max_member_count = team.max_member_count

    if member_count > max_member_count
      record.errors.add(:base, "メンバーの登録上限数を超えています")
    end
  end
end
