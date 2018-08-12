require 'rails_helper'

RSpec.describe Owners::ShiftRegistrationsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  describe 'GET #new' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :new, params: { member_id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        it 'newテンプレートがレンダリングされる' do
          get :new, params: { member_id: member.id }
          expect(response).to render_template :new
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :new, params: { member_id: other_member.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

end
