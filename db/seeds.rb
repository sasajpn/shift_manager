Admin.create(email: 'admin@example.com', password: 'password')
user = User.new(
  email: "user@example.com", password: 'password',
  last_name_kana: 'タナカ', first_name_kana: 'タロウ',
  last_name: '田中', first_name: '太郎'
)
user.skip_confirmation!
user.save

owner = Owner.new(
  email: "owner@example.com", password: 'password',
  last_name_kana: 'ナカタ', first_name_kana: 'タロウ',
  last_name: '中田', first_name: '太郎',
  max_team_count: 1
)
owner.skip_confirmation!
owner.save

1.upto(50) do |n|
  owner = Owner.new(
    email: "owner#{n}@example.com", password: 'password',
    last_name_kana: 'シハイニン', first_name_kana: 'タロウ',
    last_name: '支配人', first_name: '太郎'
  )
  owner.skip_confirmation!
  owner.save
end

1.upto(50) do |n|
  user = User.new(
    email: "user#{n}@example.com", password: 'password',
    last_name_kana: 'ジュウギョウイン', first_name_kana: 'タロウ',
    last_name: '従業員', first_name: '太郎'
  )
  user.skip_confirmation!
  user.save
end

Owner.first.teams.create(
    name: 'ABC株式会社',
    open_time: '08:00', close_time: '18:00',
    active_until: Time.current.next_month,
    max_member_count: 50
)

1.upto(50) do |n|
  Team.first.members.create(
    user_id: User.find(n).id,
    role: 'part_timer',
    calendar_color: '#00c0ef',
    approve: true
  )
end
shift_submission = Member.first.shift_submissions.create(
  submitted_date: Date.tomorrow,
  start_time: '10:00',
  end_time: '15:00'
)
shift_submission.create_shift_adjustment(
  start_time: '12:00',
  end_time: '15:00',
  account_type: 'Owner',
  account_id: team.first.owner.id
)
