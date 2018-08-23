require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::ShiftAdjustmentsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:part_timer) { create(:member, :part_timer, team: team) }
  let!(:full_timer) { create(:member, :full_timer, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_submission) { create(:shift_submission, member: member) }
  let!(:part_timer_shift_submission) { create(:shift_submission, member: part_timer) }
  let!(:full_timer_shift_submission) { create(:shift_submission, member: full_timer) }
  let!(:manager_shift_submission) { create(:shift_submission, member: manager) }

  let!(:shift_adjustment) { create(:shift_adjustment, shift_submission: shift_submission) }
  let!(:part_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: part_timer_shift_submission) }
  let!(:full_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: full_timer_shift_submission) }
  let!(:manager_shift_adjustment) { create(:shift_adjustment, shift_submission: manager_shift_submission) }

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
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: manager_shift_submission.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: full_timer_shift_submission.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: part_timer_shift_submission.id }
                expect(response).to render_template :new
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: manager_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: full_timer_shift_submission.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: part_timer_shift_submission.id }
                expect(response).to render_template :new
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: manager_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: full_timer_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { shift_submission_id: part_timer_shift_submission.id }
                expect(response).to render_template :new
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :new, params: { shift_submission_id: shift_submission.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
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
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: manager_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: full_timer_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: manager_shift_adjustment.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: full_timer_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: manager_shift_adjustment.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: full_timer_shift_adjustment.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_adjustment.id }
                expect(response).to render_template :edit
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :edit, params: { id: shift_adjustment.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
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
        delete :destroy, params: { id: full_timer_shift_adjustment.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        let!(:my_member) { create(:member, role: role, shift_coordinator: shift_coordinator, team: team, user: subject.current_user) }
        context 'シフト調整権限がある場合' do
          let!(:shift_coordinator) { true }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: manager_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が削除されない' do
                expect {
                  delete :destroy, params: { id: manager_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(0)
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が削除されない' do
                expect {
                  delete :destroy, params: { id: manager_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(0)
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が削除されない' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(0)
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_adjustment.id }
                }.to change(Shift::Adjustment, :count).by(-1)
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
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
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
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
