require 'rails_helper'

RSpec.describe Users::Managers::MembersController, type: :controller do
  login_user

  let!(:team) { create(:team) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, :manager, team: team, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがmanagerかつログイン済みのユーザーのものである場合' do
        it 'indexテンプレートがレンダリングされる' do
          get :index, params: { team_id: team.id }
          expect(response).to render_template :index
        end
      end
      context 'メンバーがmanagerかつログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: other_team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがmanagerかつログイン済みのユーザーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: member.id }
          expect(response).to render_template :show
        end
      end
      context 'メンバーがmanagerかつログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: member.id }
          expect(response).to render_template :edit
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
