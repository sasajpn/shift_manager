FactoryBot.define do
  factory :shift do
    # account_type "MyString"
    # account_id 1

    trait :tomorrow do
      registered_date Date.tomorrow
    end

    trait :april_first do
      registered_date Date.new(2018, 4, 1)
    end

    trait :eight_am_to_three_pm do
      start_time '08:00'
      end_time '15:00'
    end
  end

  factory :shift_adjustment, parent: :shift, class: 'Shift::Adjustment' do
    shift_submission { create(:shift_submission) }
  end
  #
  # factory :shift_registration, parent: :shift, class: 'Shift::Registration' do
  #   member { create(:member) }
  # end
end
