require 'rails_helper'

describe MemberDecorator do
  let(:member) { Member.new.extend MemberDecorator }
  subject { member }
  it { should be_a Member }
end
