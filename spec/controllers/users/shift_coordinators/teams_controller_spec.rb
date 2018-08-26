require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::TeamsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        let!(:my_member) { create(:member, shift_coordinator: shift_coordinator, team: team, user: subject.current_user) }
        context 'シフト調整権限がある場合' do
          let!(:shift_coordinator) { true }
          it 'showテンプレートがレンダリングされる' do
            get :show, params: { id: team.id }
            expect(response).to render_template :show
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:shift_coordinator) { false }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :show, params: { id: team.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end


  describe 'PATCH #update_identifier' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update_identifier, params: { id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのマネージャーである場合' do
        let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
        it '認証コードが更新される' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).not_to eq identifier
        end
        it 'チームのshowページにリダイレクトされる' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_shift_coordinators_team_url(team)
        end
      end
      context '自チームのマネージャーでない場合' do
        let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
        it '認証コードが更新されない' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).to eq identifier
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context '他チームのマネージャーである場合' do
        let!(:other_member) { create(:member, :manager, :shift_coordinator, user: subject.current_user) }
        it '認証コードが更新されない' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).to eq identifier
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
