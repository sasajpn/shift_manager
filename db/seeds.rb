Admin.create(email: 'admin@example.com', password: 'password')
User.create(
  email: "user@example.com", password: 'password',
  last_name_kana: 'タナカ', first_name_kana: 'タロウ',
  last_name: '田中', first_name: '太郎'
)

1.upto(50) do |n|
  Owner.create(
    email: "owner#{n}@example.com", password: 'password',
    last_name_kana: 'シハイニン', first_name_kana: 'タロウ',
    last_name: '支配人', first_name: '太郎'
  )
end

1.upto(50) do |n|
  User.create(
    email: "user#{n}@example.com", password: 'password',
    last_name_kana: 'ジュウギョウイン', first_name_kana: 'タロウ',
    last_name: '従業員', first_name: '太郎'
  )
end

Owner.first.teams.create(name: 'ABC株式会社', open_time: '08:00', close_time: '18:00')

Team.first.members.create(user_id: User.first.id, role: 'part_timer')
