require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::ShiftSubmissionsController, type: :controller do
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
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: manager_shift_submission.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer_shift_submission.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer_shift_submission.id }
                expect(response).to render_template :show
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :show, params: { id: manager_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer_shift_submission.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer_shift_submission.id }
                expect(response).to render_template :show
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :show, params: { id: manager_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer_shift_submission.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト希望がパートタイマーのものである場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer_shift_submission.id }
                expect(response).to render_template :show
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :show, params: { id: shift_submission.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
