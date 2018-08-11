require 'rails_helper'

RSpec.describe Owners::TeamsController, type: :controller do
  login_owner
  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  describe 'GET #show' do
    context 'ログイン済みで、チームがログイン済みのオーナーのものである場合' do
      it 'showテンプレートがrenderされる' do
        get :show, params: { id: team.id }
        expect(response).to render_template :show
      end
    end
    context 'ログイン済みで、チームがログイン済みのオーナーのものでない場合' do
      it 'ホーム画面にリダイレクトする' do
        get :show, params: { id: other_team.id }
        expect(response).to redirect_to owners_home_index_url
      end
    end
  end
end
