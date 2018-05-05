require 'rails_helper'

describe ShiftSubmissionDecorator do
  let(:shift_submission) { ShiftSubmission.new.extend ShiftSubmissionDecorator }
  subject { shift_submission }
  it { should be_a ShiftSubmission }
end
