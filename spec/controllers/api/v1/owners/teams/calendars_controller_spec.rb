require 'rails_helper'

RSpec.describe Api::V1::Owners::Teams::CalendarsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it '200が返ってくる' do
          get :index, params: { team_id: team.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it '404が返ってくる' do
          get :index, params: { team_id: other_team.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
