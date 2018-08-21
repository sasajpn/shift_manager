FactoryBot.define do
  factory :shift_submission do
    member { create(:member) }
    approve false
    submitted_date Date.tomorrow
    start_time '08:00'
    end_time '15:00'

    trait :tomorrow do
      submitted_date Date.tomorrow
    end

    trait :april_first do
      submitted_date Date.new(2018, 4, 1)
    end

    trait :eight_am_to_three_pm do
      start_time '08:00'
      end_time '15:00'
    end
  end
end
