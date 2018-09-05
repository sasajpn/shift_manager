FactoryBot.define do
  factory :team do
    owner { create(:owner) }
    name 'テスト株式株式会社'
    open_time '08:00'
    close_time '22:00'
    max_member_count 2
  end
end
