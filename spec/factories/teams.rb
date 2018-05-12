FactoryBot.define do
  factory :team do
    owner { create(:owner) }
    name 'ABC株式株式会社'
    identifier 'AAA'
    open_time '08:00'
    close_time '22:00'
  end
end
