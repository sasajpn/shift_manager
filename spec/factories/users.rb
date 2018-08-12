FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    last_name_kana 'ジュウギョウイン'
    first_name_kana 'タロウ'
    last_name '従業員'
    first_name '太郎'
    confirmed_at Date.today
  end
end
