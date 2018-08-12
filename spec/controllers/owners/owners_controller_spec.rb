require 'rails_helper'

RSpec.describe Owners::OwnersController, type: :controller do
  login_owner

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit
        expect(response).to redirect_to new_owner_session_url
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
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      it '登録内容が更新される' do
        patch :update, params: { owner: { last_name_kana: 'シテンチョウ', last_name: '支店長' } }
        subject.current_owner.reload
        expect(subject.current_owner.last_name_kana).to eq 'シテンチョウ'
        expect(subject.current_owner.last_name).to eq '支店長'
      end
      it 'オーナーの登録内容変更ページにリダイレクトされる' do
        patch :update
        expect(response).to redirect_to edit_owners_owner_url
      end
    end
  end

  describe 'PATCH #destroy_unconfirmed_email' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :destroy_unconfirmed_email
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      it 'unconfirmed_emailが空になる' do
        subject.current_owner.update(unconfirmed_email: 'owner@update.com')
        patch :destroy_unconfirmed_email
        expect(subject.current_owner.unconfirmed_email).to eq ''
      end
      it 'オーナーの登録内容変更ページにリダイレクトされる' do
        patch :destroy_unconfirmed_email
        expect(response).to redirect_to edit_owners_owner_url
      end
    end
  end
end
