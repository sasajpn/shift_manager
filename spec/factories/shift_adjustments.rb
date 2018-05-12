FactoryBot.define do
  factory :shift_adjustment do
    shift_submission { create(:shift_submission) }

    trait :eight_am_to_three_pm do
      start_time '08:00'
      end_time '15:00'
    end
  end
end
