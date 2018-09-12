require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do
  login_user

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it 'editテンプレートがレンダリングされる' do
        get :edit
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it 'unconfirmed_emailが空になる' do
        patch :update, params: { user: { last_name_kana: 'ヤマダ', last_name: '山田' } }
        subject.current_user.reload
        expect(subject.current_user.last_name_kana).to eq 'ヤマダ'
        expect(subject.current_user.last_name).to eq '山田'
      end
      it 'ユーザーの登録内容変更ページにリダイレクトされる' do
        patch :update
        expect(response).to redirect_to edit_users_user_url
      end
    end
  end

  describe 'PATCH #destroy_unconfirmed_email' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :destroy_unconfirmed_email
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it 'unconfirmed_emailが空になる' do
        subject.current_user.update(unconfirmed_email: 'user@update.com')
        patch :destroy_unconfirmed_email
        subject.current_user.reload
        expect(subject.current_user.unconfirmed_email).to eq ''
      end
      it 'ユーザーの登録内容変更ページにリダイレクトされる' do
        patch :destroy_unconfirmed_email
        expect(response).to redirect_to edit_users_user_url
      end
    end
  end

end
