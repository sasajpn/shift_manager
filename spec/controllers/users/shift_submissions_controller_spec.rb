require 'rails_helper'

RSpec.describe Users::ShiftSubmissionsController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm) }


  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: shift_submission.id }
          expect(response).to render_template :show
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_shift_submission.id }
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
        get :new, params: { member_id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'newテンプレートがレンダリングされる' do
          get :new, params: { member_id: member.id }
          expect(response).to render_template :new
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { member_id: other_member.id }
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
        get :edit, params: { id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: shift_submission.id }
          expect(response).to render_template :edit
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        delete :destroy, params: { id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it 'シフト希望が削除される' do
          expect {
            delete :destroy, params: { id: shift_submission.id }
          }.to change(ShiftSubmission, :count).by(-1)
        end
        it 'シフト希望のindexページにリダイレクトされる' do
          delete :destroy, params: { id: shift_submission.id }
          expect(response).to redirect_to users_member_url(shift_submission.member)
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it 'シフト希望が削除されない' do
          expect {
            delete :destroy, params: { id: other_shift_submission.id }
          }.to change(ShiftSubmission, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: other_shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
