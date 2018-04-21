Admin.create(email: 'admin@example.com', password: 'password')

1.upto(50) do |n|
  Owner.create(
    email: "owner#{n}@example.com", password: 'password',
    last_name_kana: 'シハイニン', first_name_kana: 'タロウ',
    last_name: '支配人', first_name: '太郎'
  )
end
