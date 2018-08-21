require 'rails_helper'

RSpec.describe Users::FullTimers::ShiftRegistrationsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: member) }
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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のメンバーが正社員またはアルバイトである場合' do
          it 'showテンプレートがレンダリングされる' do
            get :new, params: { member_id: member.id }
            expect(response).to render_template :new
          end
        end
        context 'アクセス先のメンバーがマネージャーである場合' do
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :new, params: { member_id: manager.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :new, params: { member_id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のシフト登録が正社員またはアルバイトのものである場合' do
          it 'editテンプレートがレンダリングされる' do
            get :edit, params: { id: shift_registration.id }
            expect(response).to render_template :edit
          end
        end
        context 'アクセス先のシフト登録がマネージャーのものである場合' do
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :edit, params: { id: manager_shift_registration.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_registration.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: shift_registration.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
