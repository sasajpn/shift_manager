require 'rails_helper'

describe TeamDecorator do
  let(:team) { Team.new.extend TeamDecorator }
  subject { team }
  it { should be_a Team }
end
