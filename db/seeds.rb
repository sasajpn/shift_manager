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
  last_name: '中田', first_name: '太郎'
)

1.upto(50) do |n|
  Owner.create(
    email: "owner#{n}@example.com", password: 'password',
    last_name_kana: 'シハイニン', first_name_kana: 'タロウ',
    last_name: '支配人', first_name: '太郎'
  )
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

Owner.first.teams.create(name: 'ABC株式会社', open_time: '08:00', close_time: '18:00')

member = Team.first.members.create(user_id: User.first.id, role: 'part_timer', calendar_color: '#00c0ef')
shift_submission = member.shift_submissions.create(
  submitted_date: Date.tomorrow,
  start_time: '10:00',
  end_time: '15:00'
)
shift_submission.create_shift_adjustment(
  start_time: '12:00',
  end_time: '15:00'
)
