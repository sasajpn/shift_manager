FactoryBot.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    last_name_kana 'ジュウギョウイン'
    first_name_kana 'タロウ'
    last_name '従業員'
    first_name '太郎'
  end
end
