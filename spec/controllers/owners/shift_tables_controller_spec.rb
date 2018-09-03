require 'rails_helper'

RSpec.describe Owners::ShiftTablesController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }


  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it 'indexテンプレートがレンダリングされる' do
          get :index, params: { team_id: team.id }
          expect(response).to render_template :index
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: other_team.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end
end
