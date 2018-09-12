require 'rails_helper'

RSpec.describe Users::ShiftRegistrationsController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }

  let!(:shift_registration) { create(:shift_registration, member: member) }
  let!(:other_shift_regsistration) { create(:shift_registration) }


  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: shift_registration.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: shift_registration.id }
          expect(response).to render_template :show
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_shift_regsistration.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
