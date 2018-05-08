class JoinTeamForm
  include ActiveModel::Model

  attr_accessor :identifier,
                :team, :user

  validates :identifier, presence: true
  validate :existence_of_team, :already_joined

  def save(user)
    @user = user
    return false if invalid?
    Member.create(team_id: @team.id, user_id: @user.id)
    true
  end

  private

  def existence_of_team
    if identifier.present?
      unless @team = Team.find_by(identifier: identifier)
        errors.add(:identifier, "からチームが見つかりません")
      end
    end
  end

  def already_joined
    if @team
      if Member.find_by(user_id: @user.id, team_id: @team.id)
        errors.add(:base, "すでにそのチームに参加しています")
      end
    end
  end
end
