FactoryBot.define do
  factory :member do
    team { create(:team) }
    user { create(:user) }
    calendar_color '#FFFFFF'
    approve false
  end
end
