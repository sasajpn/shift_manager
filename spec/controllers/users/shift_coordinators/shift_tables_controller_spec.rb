require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::ShiftTablesController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }


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

end
