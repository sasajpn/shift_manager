require 'rails_helper'

RSpec.describe Owners::TeamsController, type: :controller do
  login_owner
  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      it 'indexテンプレートがレンダリングされる' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

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
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: team.id }
          expect(response).to render_template :show
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_team.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit, params: { id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :edit, params: { id: team.id }
          expect(response).to render_template :edit
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_team.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

  describe 'PATCH #update_identifier' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update_identifier, params: { id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it 'データが更新される' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to owners_team_url(team)
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          patch :update_identifier, params: { id: other_team.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end
end
