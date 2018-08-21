require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::MembersController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:part_timer) { create(:member, :part_timer, team: team) }
  let!(:full_timer) { create(:member, :full_timer, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        let!(:my_member) { create(:member, shift_coordinator: shift_coordinator, team: team, user: subject.current_user) }
        context 'シフト調整権限がある場合' do
          let!(:shift_coordinator) { true }
          it 'indexテンプレートがレンダリングされる' do
            get :index, params: { team_id: team.id }
            expect(response).to render_template :index
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:shift_coordinator) { false }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :index, params: { team_id: team.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
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
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: manager.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer.id }
                expect(response).to render_template :show
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :show, params: { id: manager.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer.id }
                expect(response).to render_template :show
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer.id }
                expect(response).to render_template :show
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it 'ユーザー用のホーム画面にリダイレクトする' do
                get :show, params: { id: manager.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: full_timer.id }
                expect(response).to redirect_to users_home_index_url
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it 'showテンプレートがレンダリングされる' do
                get :show, params: { id: part_timer.id }
                expect(response).to render_template :show
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :show, params: { id: member.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: member.id }
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
      context '自チームのマネージャーである場合' do
        let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: member.id }
          expect(response).to render_template :edit
        end
      end
      context '自チームのマネージャーでない場合' do
        let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context '他チームのマネージャーである場合' do
        let!(:other_member) { create(:member, :manager, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
