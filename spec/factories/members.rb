FactoryBot.define do
  factory :member do
    team { create(:team) }
    user { create(:user) }
    calendar_color '#FFFFFF'
    approve false

    trait :manager do
      approve true
      role 'manager'
    end

    trait :full_timer do
      approve true
      role 'full_timer'
    end

    trait :part_timer do
      approve true
      role 'part_timer'
    end

    trait :shift_coordinator do
      shift_coordinator true
    end
  end
end
