require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::ShiftRegistrationsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:part_timer) { create(:member, :part_timer, team: team) }
  let!(:full_timer) { create(:member, :full_timer, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:part_timer_shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: part_timer) }
  let!(:full_timer_shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: full_timer) }
  let!(:manager_shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: manager) }

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
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のメンバーがマネージャーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: manager.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のメンバーが正社員である場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: full_timer.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のメンバーがパートタイマーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: part_timer.id }
                expect(response).to render_template :new
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のメンバーがマネージャーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: manager.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーが正社員である場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: full_timer.id }
                expect(response).to render_template :new
              end
            end
            context 'アクセス先のメンバーがパートタイマーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: part_timer.id }
                expect(response).to render_template :new
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のメンバーがマネージャーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: manager.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーが正社員である場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: full_timer.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーがパートタイマーである場合' do
              it 'newテンプレートがレンダリングされる' do
                get :new, params: { member_id: part_timer.id }
                expect(response).to render_template :new
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :new, params: { member_id: member.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { member_id: member.id }
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
        get :edit, params: { id: shift_registration.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: manager_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: full_timer_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :edit, params: { id: manager_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: full_timer_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :edit, params: { id: manager_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :edit, params: { id: full_timer_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'editテンプレートがレンダリングされる' do
                get :edit, params: { id: part_timer_shift_registration.id }
                expect(response).to render_template :edit
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :edit, params: { id: shift_registration.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_registration.id }
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
        delete :destroy, params: { id: shift_registration.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: manager_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: manager_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(manager_shift_registration.member)
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: full_timer_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(full_timer_shift_registration.member)
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: part_timer_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(part_timer_shift_registration.member)
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'シフト登録が削除されない' do
                expect {
                  delete :destroy, params: { id: manager_shift_registration.id }
                }.to change(Shift::Registration, :count).by(0)
              end
              it 'ユーザーのホーム画面にリダイレクトされる' do
                delete :destroy, params: { id: manager_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: full_timer_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(full_timer_shift_registration.member)
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: part_timer_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(part_timer_shift_registration.member)
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト登録がマネージャーのものである場合' do
              it 'シフト登録が削除されない' do
                expect {
                  delete :destroy, params: { id: manager_shift_registration.id }
                }.to change(Shift::Registration, :count).by(0)
              end
              it 'ユーザーのホーム画面にリダイレクトされる' do
                delete :destroy, params: { id: manager_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録が正社員のものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: full_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(0)
              end
              it 'ユーザーのホーム画面にリダイレクトされる' do
                delete :destroy, params: { id: full_timer_shift_registration.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のシフト登録がパートタイマーのものである場合' do
              it 'シフト登録が削除される' do
                expect {
                  delete :destroy, params: { id: part_timer_shift_registration.id }
                }.to change(Shift::Registration, :count).by(-1)
              end
              it 'メンバーのshowページにリダイレクトされる' do
                delete :destroy, params: { id: part_timer_shift_registration.id }
                expect(response).to redirect_to users_shift_coordinators_member_url(part_timer_shift_registration.member)
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'シフト登録が削除されない' do
            expect {
              delete :destroy, params: { id: shift_registration.id }
            }.to change(Shift::Registration, :count).by(0)
          end
          it 'ユーザーのホーム画面にリダイレクトされる' do
            delete :destroy, params: { id: part_timer_shift_registration.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'シフト登録が削除されない' do
          expect {
            delete :destroy, params: { id: shift_registration.id }
          }.to change(Shift::Registration, :count).by(0)
        end
        it 'ユーザーのホーム画面にリダイレクトされる' do
          delete :destroy, params: { id: part_timer_shift_registration.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

end
