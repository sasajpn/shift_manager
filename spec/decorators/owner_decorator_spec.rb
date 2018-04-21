require 'spec_helper'

describe OwnerDecorator do
  describe 'name' do
    let!(:owner) { create(:owner).extend OwnerDecorator }
    subject { owner.name}
    context '姓名が返される' do
      it { is_expected.to eq "#{owner.last_name} #{owner.first_name}"}
    end
  end
end
