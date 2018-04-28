Admin.create(email: 'admin@example.com', password: 'password')

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

Owner.first.teams.create(name: 'ABC株式会社')

Team.first.members.create(user_id: User.first.id, role: 'part_timer')
