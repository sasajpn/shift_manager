require 'rails_helper'

RSpec.describe Users::FullTimers::ShiftAdjustmentsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:manager_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: manager) }

  let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }
  let!(:manager_shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: manager_shift_submission) }

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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のシフト希望が正社員またはアルバイトのものである場合' do
          it 'showテンプレートがレンダリングされる' do
            get :new, params: { shift_submission_id: shift_submission.id }
            expect(response).to render_template :new
          end
        end
        context 'アクセス先のシフト希望がマネージャーのものである場合' do
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :new, params: { shift_submission_id: manager_shift_submission.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { shift_submission_id: shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
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
        get :edit, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のシフト調整のシフト希望が正社員またはアルバイトのものである場合' do
          it 'editテンプレートがレンダリングされる' do
            get :edit, params: { id: shift_adjustment.id }
            expect(response).to render_template :edit
          end
        end
        context 'アクセス先のシフト調整のシフト希望がマネージャーのものである場合' do
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :edit, params: { id: manager_shift_adjustment.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_adjustment.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のシフト調整のシフト希望が正社員またはアルバイトのものである場合' do
          it 'シフト調整が削除される' do
            expect {
              delete :destroy, params: { id: shift_adjustment.id }
            }.to change(Shift::Adjustment, :count).by(-1)
          end
          it 'シフト希望のshowページにリダイレクトされる' do
            delete :destroy, params: { id: shift_adjustment.id }
            expect(response).to redirect_to users_full_timers_shift_submission_url(shift_adjustment.shift_submission)
          end
        end
        context 'アクセス先のシフト調整のシフト希望がマネージャーのものである場合' do
          it 'シフト調整が削除されない' do
            expect {
              delete :destroy, params: { id: manager_shift_adjustment.id }
            }.to change(Shift::Adjustment, :count).by(0)
          end
          it 'ユーザー用のホーム画面にリダイレクトする' do
            delete :destroy, params: { id: manager_shift_adjustment.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'シフト調整が削除されない' do
          expect {
            delete :destroy, params: { id: manager_shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: manager_shift_adjustment.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
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
