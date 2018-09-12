require 'rails_helper'

RSpec.describe Api::V1::Owners::TeamsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: team.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_team.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'チームが作成されない' do
        expect{
          post :create, params: { team: { name: 'TEST', open_time: '10:00', close_time: '12:00' } }
        }.to change(Team, :count).by(0)
      end
      it 'ログイン画面にリダイレクトする' do
        post :create
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      it 'チームが作成される' do
        expect{
          post :create, params: { team: { name: 'TEST', open_time: '10:00', close_time: '12:00' } }
        }.to change(Team, :count).by(1)
      end
      it '200が返ってくる' do
        post :create
        expect(response).to be_success
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it 'チームの登録内容が更新される' do
          patch :update, params: { id: team.id, team: { open_time: '10:00' } }
          team.reload
          expect(team.open_time).to eq '10:00'
        end
        it '200が返ってくる' do
          patch :update, params: { id: team.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'チームの登録内容が更新されない' do
          patch :update, params: { id: other_team.id, team: { open_time: '10:00' } }
          other_team.reload
          expect(other_team.open_time).to eq '08:00'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_team.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
