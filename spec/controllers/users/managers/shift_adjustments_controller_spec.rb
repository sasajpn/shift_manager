require 'rails_helper'

RSpec.describe Users::Managers::ShiftAdjustmentsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }

  let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }

  describe 'GET #new' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :new, params: { shift_submission_id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'ログイン済みユーザーがマネージャーである場合' do
        let!(:manager) { create(:member, :manager, team: team, user: subject.current_user) }
        it 'newテンプレートがレンダリングされる' do
          get :new, params: { shift_submission_id: shift_submission.id }
          expect(response).to render_template :new
        end
      end
      context 'ログイン済みユーザーがマネージャーでない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { shift_submission_id: shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームのマネージャーである場合' do
        let!(:other_manager) { create(:member, :manager, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { shift_submission_id: shift_submission.id }
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
      context 'ログイン済みユーザーがマネージャーである場合' do
        let!(:manager) { create(:member, :manager, team: team, user: subject.current_user) }
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: shift_adjustment.id }
          expect(response).to render_template :edit
        end
      end
      context 'ログイン済みユーザーがマネージャーでない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_adjustment.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームのマネージャーである場合' do
        let!(:other_manager) { create(:member, :manager, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_adjustment.id }
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
        delete :destroy, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'ログイン済みユーザーがマネージャーである場合' do
        let!(:manager) { create(:member, :manager, team: team, user: subject.current_user) }
        it 'シフト調整が削除される' do
          expect {
            delete :destroy, params: { id: shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(-1)
        end
        it 'シフト提出のshowページにリダイレクトされる' do
          delete :destroy, params: { id: shift_adjustment.id }
          expect(response).to redirect_to users_managers_shift_submission_url(shift_adjustment.shift_submission)
        end
      end
      context 'ログイン済みユーザーがマネージャーでない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'シフト調整が削除されない' do
          expect {
            delete :destroy, params: { id: shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: shift_adjustment.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームのマネージャーである場合' do
        let!(:other_manager) { create(:member, :manager, user: subject.current_user) }
        it 'シフト調整が削除されない' do
          expect {
            delete :destroy, params: { id: shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: shift_adjustment.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
