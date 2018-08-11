FactoryBot.define do
  factory :owner do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    last_name_kana 'シハイニン'
    first_name_kana 'タロウ'
    last_name '支配人'
    first_name '太郎'
    max_team_count 1
    confirmed_at Date.today
  end
end
