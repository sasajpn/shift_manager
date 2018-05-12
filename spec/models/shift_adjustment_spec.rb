require 'rails_helper'

RSpec.describe ShiftAdjustment, type: :model do
  around do |e|
    travel_to('2018-3-30') { e.run }
  end
  let!(:shift_submission) { create(:shift_submission, :april_first, :eight_am_to_three_pm) }
  let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }


  describe 'scope' do

    describe 'futures' do
      subject { ShiftAdjustment.futures }
      context '現在日付が3月30日の場合' do
        it { is_expected.to include shift_adjustment }
      end
    end
  end

  describe 'adjusted_end_time' do
    subject { shift_adjustment.adjusted_end_time }
    context '開始時間が08:00、終了時間が15:00でシフトが調整された場合' do
      it { is_expected.to eq Time.new(2018, 4, 1, 15, 0) }
    end
  end

  describe 'future?' do
    subject { shift_adjustment.future? }
    context '現在日付が3月30日の場合' do
      it { is_expected.to be_truthy }
    end
    context '現在日時が4月1日16:00の場合' do
      around do |e|
        travel_to('2018-4-1 16:00') { e.run }
      end
      it { is_expected.to be_falsey }
    end
  end
end
