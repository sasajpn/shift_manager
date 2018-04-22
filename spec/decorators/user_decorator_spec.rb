require 'rails_helper'

describe UserDecorator do
  describe 'name' do
    let!(:user) { create(:user).extend UserDecorator }
    subject { user.name }
    context '姓名が返される' do
      it { is_expected.to eq "#{user.last_name} #{user.first_name}"}
    end
  end

  describe 'name_kana' do
    let!(:user) { create(:user).extend UserDecorator }
    subject { user.name_kana }
    context 'セイメイが返される' do
      it { is_expected.to eq "#{user.last_name_kana} #{user.first_name_kana}"}
    end
  end
end
