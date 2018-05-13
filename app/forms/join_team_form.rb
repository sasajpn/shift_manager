class JoinTeamForm
  include ActiveModel::Model

  attr_accessor :identifier, :calendar_color,
                :team, :user

  validates :identifier, :calendar_color, presence: true
  validate :not_exist_team, :already_joined_team

  def save(user)
    @user = user
    return false if invalid?
    Member.create(team_id: @team.id, user_id: @user.id, calendar_color: calendar_color)
    true
  end

  private

  def not_exist_team
    if identifier.present?
      unless @team = Team.find_by(identifier: identifier)
        errors.add(:identifier, "からチームが見つかりません")
      end
    end
  end

  def already_joined_team
    if @team
      if Member.find_by(user_id: @user.id, team_id: @team.id)
        errors.add(:base, "すでにそのチームに参加しています")
      end
    end
  end
end
