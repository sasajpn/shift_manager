FactoryBot.define do
  factory :owner do
    email 'owner@example.com'
    password 'password'
    last_name_kana 'シハイニン'
    first_name_kana 'タロウ'
    last_name '支配人'
    first_name '太郎'
  end
end
