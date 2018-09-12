require 'rails_helper'

describe ShiftDecorator do
  let(:shift) { Shift.new.extend ShiftDecorator }
  subject { shift }
  it { should be_a Shift }
end
