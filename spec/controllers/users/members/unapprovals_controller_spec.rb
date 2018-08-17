require 'rails_helper'

RSpec.describe Users::Members::UnapprovalsController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :index
        expect(response).to redirect_to new_user_session_url
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
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: member.id }
          expect(response).to render_template :show
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

  describe 'GET #new' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it 'newテンプレートがレンダリングされる' do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        delete :destroy, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'メンバーが削除される' do
          expect {
            delete :destroy, params: { id: member.id }
          }.to change(Member, :count).by(-1)
        end
        it '未承認メンバーのindexページにリダイレクトされる' do
          delete :destroy, params: { id: member.id }
          expect(response).to redirect_to users_members_unapprovals_url
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'メンバーが削除されない' do
          expect {
            delete :destroy, params: { id: other_member.id }
          }.to change(Member, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: other_member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

end
