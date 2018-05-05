require 'rails_helper'

describe OwnerDecorator do
  describe 'name' do
    let!(:owner) { create(:owner).extend OwnerDecorator }
    subject { owner.name }
    context '姓名が返される' do
      it { is_expected.to eq "#{owner.last_name} #{owner.first_name}"}
    end
  end

  describe 'name_kana' do
    let!(:owner) { create(:owner).extend OwnerDecorator }
    subject { owner.name_kana }
    context 'セイメイが返される' do
      it { is_expected.to eq "#{owner.last_name_kana} #{owner.first_name_kana}"}
    end
  end
end
