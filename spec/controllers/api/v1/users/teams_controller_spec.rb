require 'rails_helper'

RSpec.describe Api::V1::Users::TeamsController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: member.team_id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'ログイン済みのユーザーがチームに所属している場合' do
        it '200が返ってくる' do
          get :show, params: { id: member.team_id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'ログイン済みのユーザーがチームに所属していない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_member.team_id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
