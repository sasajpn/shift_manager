require 'rails_helper'

RSpec.describe Api::V1::Owners::Members::CalendarsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { member_id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームものである場合' do
        it '200が返ってくる' do
          get :index, params: { member_id: member.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it '404が返ってくる' do
          get :index, params: { member_id: other_member.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
