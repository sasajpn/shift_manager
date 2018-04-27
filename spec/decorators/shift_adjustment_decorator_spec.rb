require 'rails_helper'

describe ShiftAdjustmentDecorator do
  let(:shift_adjustment) { ShiftAdjustment.new.extend ShiftAdjustmentDecorator }
  subject { shift_adjustment }
  it { should be_a ShiftAdjustment }
end
